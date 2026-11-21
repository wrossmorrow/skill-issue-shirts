
# list targets and exit
default:
    just --list

# install jekyll stuff for site
install:
    bundle install

# serve the site locally
serve:
    bundle exec jekyll serve

# deploy the site
deploy:
    SITE_BUCKET="$( terraform -chdir=terraform output -raw bucket_name )" \
    CF_DISTRIBUTION_ID="$( terraform -chdir=terraform output -raw distribution_id )" \
        ./scripts/deploy.sh
