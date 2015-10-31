require_relative 'config/autoload'

token = ENV['TELEGRAM_TOKEN']

# Create bot
bot = Telegrammer::Bot.new(token)

# Delete existing webhooks
bot.set_webhook('')

# Set webhook
response = bot.set_webhook("#{ENV['APP_URL']}/webhook/#{token}")
puts "Webhook set to: #{ENV['APP_URL']}/webhook/#{token}" if response.success

# Load all commands
command_loader = CommandLoader.new(bot)

# Initialize the dispatcher
update_dispatcher = UpdateDispatcher.new(command_loader)

Cuba.define do
  on get do
    on root do
      res.write "<a href=\"http://telegram.me/#{bot.me.username}\">#{bot.me.first_name}</a>"
    end
  end

  on post do
    on "webhook/#{token}" do
      update = Telegrammer::DataTypes::Update.new(MultiJson.load(req.body.read))

      begin
        update_dispatcher.dispatch(update)
      rescue NoReplyError
        bot.send_message chat_id: update.message.chat.id,
                         text: "I'm sorry, I do not know what you mean by '#{update.message.text}'",
                         parse_mode: 'Markdown'
      end

      res.status = 200
    end
  end
end
