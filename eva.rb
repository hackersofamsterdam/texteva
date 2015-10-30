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
      update = Telegrammer::DataTypes::Update.new MultiJson.load req.body.read

      unless update.message.text == ''
        begin
          bot.send_message chat_id: update.message.chat.id,
                           text: tac.ask(update.message.text)
        rescue NoAnswerError
          puts "Could not find matching answer for '#{update.message.text}'"
          bot.send_message chat_id: update.message.chat.id,
                           text: "I'm sorry, I don't understand that message."
        end
      end

      res.status = 200
    end
  end
end
