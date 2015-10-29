require 'cuba'
require 'json'
require 'telegrammer'
require 'tactalk'

token = ENV['TELEGRAM_TOKEN']

bot = Telegrammer::Bot.new token
tac = TacTalk.new

bot.set_webhook('')

response = bot.set_webhook("#{ENV['APP_URL']}/webhook/#{token}")

puts "Webhook set to: #{ENV['APP_URL']}/webhook/#{token}" if response.success

tac.add_question_document './questions.yml'

Cuba.define do
  on get do
    on root do
      res.write "<a href=\"http://telegram.me/#{bot.me.username}\">Eva</a>"
    end
  end

  on post do
    on "webhook/#{token}" do
      on true do
        update = Telegrammer::DataTypes::Update.new begin
          MultiJson.load req.body.read
        end

        bot.send_message chat_id: update.message.chat.id,
                         text: tac.ask(update.message.text)

        res.status = 200
      end
    end
  end
end
