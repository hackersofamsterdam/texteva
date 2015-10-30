# EVA - Telegram Bot

Small Cuba app with Telegram webhook support

### How to

- `git clone`
- `bundle install`
- `cp .env.dist .env`
- edit `.env` to fit your settings
- install [ngrok](https://ngrok.com/)
- install [foreman](https://github.com/ddollar/foreman)

First start `ngrok`
```
$ ngrok http 3000
```
Then start the app:
```
$ foreman start
```
