class Command
  # @param [Telegrammer::Bot] bot
  def initialize(bot)
    @bot = bot
  end

  # @param [Telegrammer::DataTypes::Update] update
  def set_update(update)
    @update = update
  end

  def matches?
    return if regex.nil?

    if match.nil?
      false
    else
      true
    end
  end

  def match
    regex.match(command)
  end

  def message
    @update.message.text
  end
  alias_method :command, :message

  def reply(message)
    @bot.send_message chat_id: @update.message.chat.id, text: message, parse_mode: 'Markdown'
  end
end
