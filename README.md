# Asia Insight

## Secrets config example

```yml
production:
  secret_key_base: key
  sso:
    user: secret
    password: secret
  twitter:
    consumer_key: xxxx
    consumer_secret: xxx
  mailgun:
    port: 587
    address: smtp.mailgun.org
    authentication: plain
    api_key: key
    public_key: pubkey
    domain: mailgun.org
```

## Rake tasks

Send emails
```
asia-insight run rake automatic_email_alerts:send
```

Fetch users from SSO
```
asia-insight run rake users:update_from_sso
```
