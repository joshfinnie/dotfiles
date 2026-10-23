function run_web_backend --description 'Run the revtools web_backend locally against the dev stage'
    set -l repo $HOME/src/allpdl

    if not test -d $repo
        echo "run_web_backend: allpdl repo not found at $repo" >&2
        return 1
    end

    # web_backend/__init__.py calls django.setup() at import time, so these must
    # be set before pants starts the process. Function-scoped: they do not leak
    # into the calling shell.
    set -x AWS_PROFILE dev_revtools
    set -x STAGE dev
    set -x PDL_ENV sales_dash/dev,dev/apps-databases,revtools/web_backend/dev,batch_enrichment/dev,revtools/dev

    if not aws sts get-caller-identity >/dev/null 2>&1
        echo "run_web_backend: refreshing SSO session for $AWS_PROFILE..."
        if not aws sso login --profile $AWS_PROFILE
            echo "run_web_backend: SSO login failed" >&2
            return 1
        end
    end

    echo "run_web_backend: starting on http://localhost:5004 (stage=$STAGE, profile=$AWS_PROFILE)"

    pushd $repo
    pants run src/pdl/svc/revtools/web_backend/local.py
    set -l rc $status
    popd
    return $rc
end
