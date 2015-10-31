require './lib/bol_api'

# Bol.com Lookup Command
class BolLookupCommand < Command
  include BolAPI

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
    options = api_options
    options[:query].merge!(q: match[:product],
                           offset: 0,
                           limit: 1,
                           dataoutput: 'products,categories')

    response = self.class.get('/catalog/v4/search', options)

    json = MultiJson.load response.body

    reply "I found a #{json['products'][0]['title']} in the Bol catalog.\n" \
          "Here it is: #{json['products'][0]['urls'][0]['value']}"
  end
end
