# Hosting

Private S3 bucket (named `<prefix>-<region code>`, e.g. `-usw2`) → CloudFront (origin access control) with an ACM cert, plus Route 53 records in the public zone for `domain`, looked up by name.

```sh
cd terraform
cp terraform.tfvars.example terraform.tfvars   # set domain
terraform init
terraform apply
```

Then deploy the site with the outputs:

```sh
SITE_BUCKET=$(terraform -chdir=terraform output -raw bucket_name) \
CF_DISTRIBUTION_ID=$(terraform -chdir=terraform output -raw distribution_id) \
./scripts/deploy.sh
```

## If DNS is not in Route 53

Set `manage_dns = false`. The first `apply` will create the cert and then fail at CloudFront because the cert isn't validated yet. Add the `cert_validation_records` output to your DNS, wait for ACM to show the cert as Issued, run `apply` again, then point the domain (and `www`) at `distribution_domain`.

## Notes

- The viewer-request function in `functions/rewrite.js` maps `/foo/` to `/foo/index.html` and redirects `www` to the apex.
- Missing pages return `/404.html` with a 404 status.
- No access logging is configured; add a `logging_config` block if you want CloudFront logs.
