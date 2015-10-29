#!/usr/bin/env ruby
require 'telegrammer'

bot = Telegrammer::Bot.new '156127274:AAGBC_Jiwgb5RXai7xaTuAF3if_6ZLUUB4U'

bot.set_webhook('')

bot.get_updates do |message|
  puts "In chat #{message.chat.id}, @#{message.from.username} said: #{message.text}"
  bot.send_message(chat_id: message.chat.id, text: "You said: #{message.text}")
end
