require 'uri'

class AhCommand < Command
  def help
    'Searches for products in the Albert Heijn catalog.'
  end

  def syntax
    '/ah <search query>'
  end

  def regex
    /^\/ah\s+(?<product>.*)/i
  end

  def invoke!
    product_name = match[:product]

    # TODO: Do search in AH.
    link = "https://google.com/?q=albert+heijn+#{URI.encode(product_name)}"

    reply "I found a #{product_name} in the Albert Heijn catalog. You can find it [here](#{link})."
  end
end
