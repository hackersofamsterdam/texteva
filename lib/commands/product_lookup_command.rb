require './lib/clients/bol_client'
require './lib/models/fridge'

# Bol.com Lookup Command
class ProductLookupCommand < Command
  def help
    'Searches for products in the Bol.com catalog.'
  end

  def syntax
    '/p <search query>'
  end

  def regex
    /^\/p\s+(?<product>.*)/i
  end

  def invoke!
    response = BolClient.new.catalog match[:product]
    json = MultiJson.load response.body
    fridge = Fridge.find_or_initialize token: chat_id

    fridge.update contents: json['products']

    reply "I found #{json['products'].count} items:"

    json['products'].each_with_index do |product, idx|
      reply "*[#{idx + 1}] #{product['title']}*\n#{product['urls'][0]['value']}"
    end

    reply "**If you would like to buy one type**\n" \
          '*/pb <number>* example: /pb 2'
  end
end
