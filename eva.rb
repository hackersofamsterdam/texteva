require 'cuba'
require 'json'
require 'telegrammer'

token = ENV['TELEGRAM_TOKEN']
bot = Telegrammer::Bot.new token

bot.set_webhook('')

response = bot.set_webhook("#{ENV['APP_URL']}/webhook")

puts "Webhook set to: #{ENV['APP_URL']}/webhook" if response.success

Cuba.define do
  on get do
    on root do
      res.write "http://telegram.me/#{bot.me.username}"
    end
  end

  on post do
    on 'webhook' do
      on true do
        post = JSON.parse req.body.read

        bot.send_message chat_id: post['message']['chat']['id'],
                         text: "You said: #{post['message']['text']}"

        res.status = 200
      end
    end
  end
end
