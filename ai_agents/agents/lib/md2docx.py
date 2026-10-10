#!/usr/bin/env python3
"""Convert an APA-flavored Markdown source into a .docx file.

Standard library only: a .docx is a zip of OOXML parts, so no pandoc or
python-docx needed. Output targets APA 7 student-paper formatting (Times New
Roman 12pt, double spaced, 1in margins, page number in the header, hanging
indent references) so the file needs little cleanup after upload to Google Docs.

Usage:
    python3 md2docx.py input.md output.docx
"""

import argparse
import re
import sys
import zipfile

W = "http://schemas.openxmlformats.org/wordprocessingml/2006/main"
R = "http://schemas.openxmlformats.org/officeDocument/2006/relationships"

TWIPS_INCH = 1440


def esc(text):
    return (
        text.replace("&", "&amp;").replace("<", "&lt;").replace(">", "&gt;")
    )


# --------------------------------------------------------------------------
# source parsing
# --------------------------------------------------------------------------


def split_frontmatter(source):
    meta = {}
    lines = source.splitlines()
    if lines and lines[0].strip() == "---":
        for i in range(1, len(lines)):
            if lines[i].strip() == "---":
                body = "\n".join(lines[i + 1 :])
                break
            if ":" in lines[i]:
                key, _, value = lines[i].partition(":")
                meta[key.strip()] = value.strip().strip('"').strip("'")
        else:
            return meta, source
        return meta, body
    return meta, source


def parse_blocks(body):
    """Turn Markdown text into a flat list of block dicts."""
    blocks = []
    lines = body.splitlines()
    i = 0
    while i < len(lines):
        line = lines[i]
        stripped = line.strip()

        if not stripped:
            i += 1
            continue

        heading = re.match(r"^(#{1,3})\s+(.*)$", stripped)
        if heading:
            blocks.append(
                {
                    "type": "heading",
                    "level": len(heading.group(1)),
                    "text": heading.group(2).strip(),
                }
            )
            i += 1
            continue

        if stripped.startswith("|") and i + 1 < len(lines) and re.match(
            r"^\|[\s:\-|]+\|$", lines[i + 1].strip()
        ):
            rows = []
            while i < len(lines) and lines[i].strip().startswith("|"):
                rows.append(lines[i].strip())
                i += 1
            header = [c.strip() for c in rows[0].strip("|").split("|")]
            data = [
                [c.strip() for c in row.strip("|").split("|")] for row in rows[2:]
            ]
            blocks.append({"type": "table", "header": header, "rows": data})
            continue

        if stripped.startswith(">"):
            quote = []
            while i < len(lines) and lines[i].strip().startswith(">"):
                quote.append(lines[i].strip().lstrip(">").strip())
                i += 1
            blocks.append({"type": "quote", "text": " ".join(quote)})
            continue

        para = []
        while i < len(lines) and lines[i].strip() and not lines[i].strip().startswith(
            ("#", ">", "|")
        ):
            para.append(lines[i].strip())
            i += 1
        blocks.append({"type": "paragraph", "text": " ".join(para)})

    return blocks


INLINE = re.compile(
    r"(\*\*.+?\*\*)"          # bold
    r"|(\*[^*]+?\*)"          # italic
    r"|(\[[^\]]+\]\([^)]+\))"  # link
)


def runs(text, rels):
    """Render inline Markdown to a list of OOXML run strings."""
    out = []
    pos = 0
    for match in INLINE.finditer(text):
        if match.start() > pos:
            out.append(run(text[pos : match.start()]))
        token = match.group(0)
        if token.startswith("**"):
            out.append(run(token[2:-2], bold=True))
        elif token.startswith("["):
            label, url = re.match(r"\[([^\]]+)\]\(([^)]+)\)", token).groups()
            out.append(hyperlink(label, url, rels))
        else:
            out.append(run(token[1:-1], italic=True))
        pos = match.end()
    if pos < len(text):
        out.append(run(text[pos:]))
    return "".join(out)


def run(text, bold=False, italic=False):
    if not text:
        return ""
    props = ""
    if bold or italic:
        props = "<w:rPr>{}{}</w:rPr>".format(
            "<w:b/>" if bold else "", "<w:i/>" if italic else ""
        )
    return '<w:r>{}<w:t xml:space="preserve">{}</w:t></w:r>'.format(
        props, esc(text)
    )


def hyperlink(label, url, rels):
    rid = "rIdLink{}".format(len(rels) + 1)
    rels.append((rid, url))
    return (
        '<w:hyperlink r:id="{}"><w:r><w:rPr><w:color w:val="0563C1"/>'
        '<w:u w:val="single"/></w:rPr><w:t xml:space="preserve">{}</w:t>'
        "</w:r></w:hyperlink>".format(rid, esc(label))
    )


# --------------------------------------------------------------------------
# document assembly
# --------------------------------------------------------------------------


def paragraph(content, align=None, indent=None, spacing=None, keep_next=False):
    props = []
    if spacing:
        props.append(spacing)
    else:
        props.append('<w:spacing w:line="480" w:lineRule="auto" w:after="0"/>')
    if align:
        props.append('<w:jc w:val="{}"/>'.format(align))
    if indent:
        props.append(indent)
    if keep_next:
        props.append("<w:keepNext/>")
    return "<w:p><w:pPr>{}</w:pPr>{}</w:p>".format("".join(props), content)


def page_break():
    return '<w:p><w:r><w:br w:type="page"/></w:r></w:p>'


HEADING_ALIGN = {1: "center", 2: "left", 3: "left"}


def heading(level, text, rels):
    inner = "<w:r><w:rPr><w:b/>{}</w:rPr><w:t>{}</w:t></w:r>".format(
        "<w:i/>" if level == 3 else "", esc(text)
    )
    return paragraph(inner, align=HEADING_ALIGN[level], keep_next=True)


def table(block, rels):
    borders = (
        "<w:tblBorders>"
        '<w:top w:val="single" w:sz="6" w:color="000000"/>'
        '<w:bottom w:val="single" w:sz="6" w:color="000000"/>'
        '<w:insideH w:val="none" w:sz="0" w:color="auto"/>'
        '<w:insideV w:val="none" w:sz="0" w:color="auto"/>'
        '<w:left w:val="none" w:sz="0" w:color="auto"/>'
        '<w:right w:val="none" w:sz="0" w:color="auto"/>'
        "</w:tblBorders>"
    )
    props = (
        "<w:tblPr>"
        '<w:tblW w:w="5000" w:type="pct"/>'
        + borders
        + '<w:tblLayout w:type="autofit"/>'
        "</w:tblPr>"
    )

    def cell(text, bold=False, header=False):
        edge = (
            '<w:tcBorders><w:bottom w:val="single" w:sz="6" w:color="000000"/>'
            "</w:tcBorders>"
            if header
            else ""
        )
        body = paragraph(
            runs(text, rels) if not bold else run(text, bold=True),
            spacing='<w:spacing w:line="240" w:lineRule="auto" w:after="0"/>',
        )
        return "<w:tc><w:tcPr>{}</w:tcPr>{}</w:tc>".format(edge, body)

    rows = [
        "<w:tr>"
        + "".join(cell(c, bold=True, header=True) for c in block["header"])
        + "</w:tr>"
    ]
    for row in block["rows"]:
        rows.append("<w:tr>" + "".join(cell(c) for c in row) + "</w:tr>")
    return "<w:tbl>{}{}</w:tbl>{}".format(
        props, "".join(rows), paragraph("", spacing='<w:spacing w:after="0"/>')
    )


def title_page(meta):
    blank = paragraph("")
    parts = [blank, blank, blank]
    parts.append(paragraph(run(meta.get("title", ""), bold=True), align="center"))
    parts.append(blank)
    for key in ("author", "affiliation", "course", "instructor", "due_date"):
        if meta.get(key):
            parts.append(paragraph(run(meta[key]), align="center"))
    parts.append(page_break())
    return "".join(parts)


FIRST_LINE = '<w:ind w:firstLine="720"/>'
HANGING = '<w:ind w:left="720" w:hanging="720"/>'
QUOTE_IND = '<w:ind w:left="720"/>'


def build_body(meta, blocks, rels):
    """Render blocks. The frontmatter title feeds the title page only; the
    body must open with the title as its own level 1 heading, as APA wants."""
    out = []
    show_title_page = str(meta.get("title_page", "true")).lower() not in (
        "false",
        "no",
        "0",
    )
    at_page_start = False
    if show_title_page and meta.get("title"):
        out.append(title_page(meta))
        at_page_start = True

    section = None
    for block in blocks:
        if block["type"] == "heading":
            name = block["text"].strip().lower()
            if block["level"] == 1 and name in ("references", "abstract"):
                if not at_page_start:
                    out.append(page_break())
                section = name
            elif block["level"] == 1:
                if section == "abstract" and not at_page_start:
                    out.append(page_break())
                section = "body"
            out.append(heading(block["level"], block["text"], rels))
            at_page_start = False
        elif block["type"] == "table":
            out.append(table(block, rels))
            at_page_start = False
        elif block["type"] == "quote":
            out.append(paragraph(runs(block["text"], rels), indent=QUOTE_IND))
            at_page_start = False
        else:
            if section == "references":
                indent = HANGING
            elif section == "abstract":
                indent = None
            else:
                indent = FIRST_LINE
            out.append(paragraph(runs(block["text"], rels), indent=indent))
            at_page_start = False
    return "".join(out)


SECT_PR = (
    "<w:sectPr>"
    '<w:headerReference w:type="default" r:id="rIdHeader"/>'
    '<w:pgSz w:w="12240" w:h="15840"/>'
    '<w:pgMar w:top="1440" w:right="1440" w:bottom="1440" w:left="1440"'
    ' w:header="720" w:footer="720" w:gutter="0"/>'
    "</w:sectPr>"
)


def document_xml(body):
    return (
        '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>'
        '<w:document xmlns:w="{w}" xmlns:r="{r}"><w:body>{body}{sect}</w:body>'
        "</w:document>".format(w=W, r=R, body=body, sect=SECT_PR)
    )


STYLES_XML = (
    '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>'
    '<w:styles xmlns:w="{w}">'
    "<w:docDefaults><w:rPrDefault><w:rPr>"
    '<w:rFonts w:ascii="Times New Roman" w:hAnsi="Times New Roman"'
    ' w:eastAsia="Times New Roman" w:cs="Times New Roman"/>'
    '<w:sz w:val="24"/><w:szCs w:val="24"/><w:lang w:val="en-US"/>'
    "</w:rPr></w:rPrDefault><w:pPrDefault><w:pPr>"
    '<w:spacing w:after="0" w:line="480" w:lineRule="auto"/>'
    "</w:pPr></w:pPrDefault></w:docDefaults>"
    '<w:style w:type="paragraph" w:default="1" w:styleId="Normal">'
    '<w:name w:val="Normal"/></w:style>'
    "</w:styles>".format(w=W)
)

HEADER_XML = (
    '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>'
    '<w:hdr xmlns:w="{w}"><w:p><w:pPr><w:jc w:val="right"/>'
    '<w:spacing w:line="240" w:lineRule="auto" w:after="0"/></w:pPr>'
    '<w:r><w:fldChar w:fldCharType="begin"/></w:r>'
    '<w:r><w:instrText xml:space="preserve"> PAGE </w:instrText></w:r>'
    '<w:r><w:fldChar w:fldCharType="separate"/></w:r>'
    "<w:r><w:t>1</w:t></w:r>"
    '<w:r><w:fldChar w:fldCharType="end"/></w:r>'
    "</w:p></w:hdr>".format(w=W)
)

CONTENT_TYPES = (
    '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>'
    '<Types xmlns="http://schemas.openxmlformats.org/package/2006/content-types">'
    '<Default Extension="rels" ContentType="application/vnd.openxmlformats-package.relationships+xml"/>'
    '<Default Extension="xml" ContentType="application/xml"/>'
    '<Override PartName="/word/document.xml" ContentType="application/vnd.openxmlformats-officedocument.wordprocessingml.document.main+xml"/>'
    '<Override PartName="/word/styles.xml" ContentType="application/vnd.openxmlformats-officedocument.wordprocessingml.styles+xml"/>'
    '<Override PartName="/word/header1.xml" ContentType="application/vnd.openxmlformats-officedocument.wordprocessingml.header+xml"/>'
    "</Types>"
)

ROOT_RELS = (
    '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>'
    '<Relationships xmlns="http://schemas.openxmlformats.org/package/2006/relationships">'
    '<Relationship Id="rId1" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/officeDocument" Target="word/document.xml"/>'
    "</Relationships>"
)


def document_rels(links):
    items = [
        '<Relationship Id="rIdStyles" Type="{r}/styles" Target="styles.xml"/>'.format(
            r=R
        ),
        '<Relationship Id="rIdHeader" Type="{r}/header" Target="header1.xml"/>'.format(
            r=R
        ),
    ]
    for rid, url in links:
        items.append(
            '<Relationship Id="{rid}" Type="{r}/hyperlink" Target="{url}"'
            ' TargetMode="External"/>'.format(rid=rid, r=R, url=esc(url))
        )
    return (
        '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>'
        '<Relationships xmlns="http://schemas.openxmlformats.org/package/2006/relationships">'
        "{}</Relationships>".format("".join(items))
    )


def convert(source, destination):
    with open(source, encoding="utf-8") as handle:
        meta, body_text = split_frontmatter(handle.read())

    rels = []
    body = build_body(meta, parse_blocks(body_text), rels)

    with zipfile.ZipFile(destination, "w", zipfile.ZIP_DEFLATED) as docx:
        docx.writestr("[Content_Types].xml", CONTENT_TYPES)
        docx.writestr("_rels/.rels", ROOT_RELS)
        docx.writestr("word/document.xml", document_xml(body))
        docx.writestr("word/styles.xml", STYLES_XML)
        docx.writestr("word/header1.xml", HEADER_XML)
        docx.writestr("word/_rels/document.xml.rels", document_rels(rels))


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("source", help="Markdown source file")
    parser.add_argument("destination", help="output .docx path")
    args = parser.parse_args()
    convert(args.source, args.destination)
    print("wrote {}".format(args.destination), file=sys.stderr)


if __name__ == "__main__":
    main()
