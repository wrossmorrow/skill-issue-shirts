# Shirt shop starter

A minimal Jekyll storefront: a grid of shirts, a page per shirt with size buttons that link to hosted checkout, and an S3/CloudFront deploy.

## Run locally

```sh
bundle install
bundle exec jekyll serve
```

## Add a shirt

Copy `_shirts/example-shirt.md` to `_shirts/<name>.md`, drop photos in `assets/img/`, and fill in the front matter:

- `price`, `made_by`, `order` (sort position on the home page)
- `images`: list of image paths; the first is the card thumbnail
- `sizes`: one entry per size with its checkout `link`; set `sold_out: true` (or leave `link` empty) to grey it out
- `draft: true` hides it from the home page

## Checkout

Each size button is just a link. Stripe Payment Links work well: one link per design and size, with shipping-address collection on, a payment limit equal to your stock, and the post-payment redirect set to `https://<your-domain>/thanks/`.

## Deploy

```sh
SITE_BUCKET=<bucket> CF_DISTRIBUTION_ID=<id> ./scripts/deploy.sh
```

Set `url` in `_config.yml` to your domain first.

## Later

- A Stripe webhook to a Lambda for order emails and auto sold-out
- An agent or small admin form that drafts `_shirts/*.md` files as PRs
