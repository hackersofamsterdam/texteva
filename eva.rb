token = ENV['TELEGRAM_TOKEN']

# Create bot
bot = Telegrammer::Bot.new(token)

# Delete existing webhooks
bot.set_webhook('')

# Set webhook
response = bot.set_webhook("#{ENV['APP_URL']}/webhook/#{token}")
puts "Webhook set to: #{ENV['APP_URL']}/webhook/#{token}" if response.success

def flight_response(_text)
  'flight info'
end

def food_response(_text)
  'food info'
end

def book_response(_text)
  'book info'
end

def buy_response(_text)
  'buy info'
end

def unknown_response(_text)
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

      unless update.message.text.nil? or update.message.text.empty?
        case update.message.text
          when '/flight' # add regex
            response = flight_response update.message.text
          when '/book' # add regex
            response = book_response update.message.text
          when '/food' # add regex
            response = food_response update.message.text
          when '/buy' # add regex
            response = buy_response update.message.text
          else
            response = unknown_response update.message.text
        end

        bot.send_message chat_id: update.message.chat.id, text: response
      end

      res.status = 200
    end
  end
end
