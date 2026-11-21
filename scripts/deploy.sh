#!/usr/bin/env bash
# Build the site and push it to S3 behind CloudFront.
# Usage: SITE_BUCKET=my-bucket CF_DISTRIBUTION_ID=E123ABC ./scripts/deploy.sh
set -euo pipefail

: "${SITE_BUCKET:?set SITE_BUCKET}"
: "${CF_DISTRIBUTION_ID:?set CF_DISTRIBUTION_ID}"

JEKYLL_ENV=production bundle exec jekyll build

aws s3 sync _site/ "s3://${SITE_BUCKET}/" --delete

aws cloudfront create-invalidation \
  --distribution-id "${CF_DISTRIBUTION_ID}" \
  --paths "/*"
