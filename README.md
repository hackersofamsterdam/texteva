# EVA - Telegram Bot

Small Cuba app with Telegram webhook support

### How to

- `git clone`
- `bundle install`
- install [ngrok](https://ngrok.com/)
- install [foreman](https://github.com/ddollar/foreman)

First start `ngrok`
```
$ ngrok http 3000
```
Then start the app:
```
$ TELEGRAM_TOKEN=<your token> APP_URL=https://<random string>.ngrok.io foreman start
```
