require './lib/clients/bol_client'
require './lib/models/fridge'

# Bol.com Lookup Command
class BolLookupCommand < Command
  def help
    'Searches for products in the Bol.com catalog.'
  end

  def syntax
    '/bol <search query>'
  end

  def regex
    /^\/bol\s+(?<product>.*)/i
  end

  def invoke!
    response = BolClient.new.catalog match[:product]
    json = MultiJson.load response.body
    store = Fridge.find_by_chat_id(message.chat.id) || Fridge.new(chat_id: message.chat.id)

    store.update contents: json['products']

    reply "I found a *#{json['products'][0]['title']}* in the Bol catalog.\n" \
          "Here it is: #{json['products'][0]['urls'][0]['value']}"
  end
end
