#============================================================
#
# PERSONAL .bashrc FILE
# By Josh Finnie <josh@jfin.us>
#
# Last modified: 3 Nov 2010
#
#=============================================================

#-------------------------------------------------------------
# Bash Prompt
#-------------------------------------------------------------
PS1='<\t>[\u@\h \w]\$ '

#-------------------------------------------------------------
# The git family
#-------------------------------------------------------------
alias g='git'
alias gi='git init && printf ".DS_Store\nThumbs.db\n" >> .gitignore && git add .gitignore'
alias gs='git status'
alias gd='git diff'
alias ga='git add'
alias gap='git add -p'
alias gc='git commit -v'
alias gca='gc -a'
alias gco='git checkout'
alias gp='git push origin master'

#-------------------------------------------------------------
# Easier naviagation of files
#-------------------------------------------------------------
alias f='cd ../'
alias ff='cd ../../'
alias h='cd'

#-------------------------------------------------------------
# Safety first...
#-------------------------------------------------------------
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias mkdir='mkdir -p'

#-------------------------------------------------------------
# The 'ls' family (this assumes you use a recent GNU ls)
#-------------------------------------------------------------
alias ll="ls -l --group-directories-first"
alias ls='ls -hF --color'  # add colors for filetype recognition
alias la='ls -Al'          # show hidden files
alias lx='ls -lXB'         # sort by extension
alias lk='ls -lSr'         # sort by size, biggest last
alias lc='ls -ltcr'        # sort by and show change time, most recent last
alias lu='ls -ltur'        # sort by and show access time, most recent last
alias lt='ls -ltr'         # sort by date, most recent last
alias lm='ls -al |more'    # pipe through 'more'
alias lr='ls -lR'          # recursive ls
alias tree='tree -Csu'     # nice alternative to 'recursive ls'

function extract()      # Handy Extract Program.
{
	if [ -f $1 ] ; then
	case $1 in
		*.tar.bz2)   tar xvjf $1     ;;
	    *.tar.gz)    tar xvzf $1     ;;
	    *.bz2)       bunzip2 $1      ;;
	    *.rar)       unrar x $1      ;;
	    *.gz)        gunzip $1       ;;
	    *.tar)       tar xvf $1      ;;
	    *.tbz2)      tar xvjf $1     ;;
	    *.tgz)       tar xvzf $1     ;;
	    *.zip)       unzip $1        ;;
	    *.Z)         uncompress $1   ;;
	    *.7z)        7z x $1         ;;
	    *)           echo "'$1' cannot be extracted via >extract<" ;;
	    esac
	else
	    echo "'$1' is not a valid file"
	fi
}

#-------------------------------------------------------------
# Easier Ubuntu
#-------------------------------------------------------------
alias supdate='sudo apt-get update'
alias supgrade='sudo apt-get upgrade'
alias sinstall='sudo apt-get install'
alias install='apt-get install' # mostly for webfaction

#-------------------------------------------------------------
# Lynx bookmarks
#-------------------------------------------------------------
alias google='lynx http://google.com'
alias hn='lynx http://news.ycombinator.com'

#-------------------------------------------------------------
# Fun functions
#-------------------------------------------------------------
# Weather by us zip code - Can be called two ways # weather 50315 # weather "Des Moines"
weather ()
{
declare -a WEATHERARRAY
WEATHERARRAY=( `lynx -dump "http://www.google.com/search?hl=en&lr=&client=firefox-a&rls=org.mozilla%3Aen-US%3Aofficial&q=weather+${1}&btnG=Search" | grep -A 5 -m 1 "Weather for"`)
echo ${WEATHERARRAY[@]}
}

# Stock prices - can be called two ways. # stock novl  (this shows stock pricing)  #stock "novell"  (this way shows stock symbol for novell)
stock ()
{
stockname=`lynx -dump http://finance.yahoo.com/q?s=${1} | grep -i ":${1})" | sed -e 's/Delayed.*$//'`
stockadvise="${stockname} - delayed quote."
declare -a STOCKINFO
STOCKINFO=(` lynx -dump http://finance.yahoo.com/q?s=${1} | egrep -i "Last Trade:|Change:|52wk Range:"`)
stockdata=`echo ${STOCKINFO[@]}`
    if [[ ${#stockname} != 0 ]] ;then
        echo "${stockadvise}"
        echo "${stockdata}"
            else
            stockname2=${1}
            lookupsymbol=`lynx -dump -nolist http://finance.yahoo.com/lookup?s="${1}" | grep -A 1 -m 1 "Portfolio" | grep -v "Portfolio" | sed 's/\(.*\)Add/\1 /'`
                if [[ ${#lookupsymbol} != 0 ]] ;then
                echo "${lookupsymbol}"
                    else
                    echo "Sorry $USER, I can not find ${1}."
                fi
    fi
}
define ()
{
lynx -dump "http://www.google.com/search?hl=en&q=define%3A+${1}&btnG=Google+Search" | grep -m 5 -w "*"  | sed 's/;/ -/g' | cut -d- -f5 > /tmp/templookup.txt
            if [[ -s  /tmp/templookup.txt ]] ;then    
                until ! read response
                    do
                    echo "${response}"
                    done < /tmp/templookup.txt
                else
                    echo "Sorry $USER, I can't find the term \"${1} \""                
            fi    
rm -f /tmp/templookup.txt
}
#Minecraft
alias mc='cd ~/Desktop && java -Xmx256M -Xms256M -cp Minecraft.jar net.minecraft.LauncherFrame'
