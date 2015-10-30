token = ENV['TELEGRAM_TOKEN']

bot = Telegrammer::Bot.new token

bot.set_webhook('')

response = bot.set_webhook("#{ENV['APP_URL']}/webhook/#{token}")

puts "Webhook set to: #{ENV['APP_URL']}/webhook/#{token}" if response.success

def flight_response
  'flight info'
end

def food_response
  'food info'
end

def book_response
  'book info'
end

def buy_response
  'buy info'
end

def unknown_response
  'unknown info'
end

Cuba.define do
  on get do
    on root do
      res.write "<a href=\"http://telegram.me/#{bot.me.username}\">Eva</a>"
    end
  end

  on post do
    on "webhook/#{token}" do
      update = Telegrammer::DataTypes::Update.new MultiJson.load(req.body.read)

      unless update.message.text.empty?
        case update.message.text
        when '/flight' # add regex
          response = flight_response
        when '/book' # add regex
          response = book_response
        when '/food' # add regex
          response = food_response
        when '/buy' # add regex
          response = buy_response
        else
          response = unknown_response
        end

        bot.send_message chat_id: update.message.chat.id, text: response
      end

      res.status = 200
    end
  end
end
