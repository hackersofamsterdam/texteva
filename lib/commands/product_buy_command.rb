require './lib/models/fridge'

# ProductBuyCommand
class ProductBuyCommand < Command
  def help
    'Searches for products in the Bol.com catalog.'
  end

  def syntax
    '/pbuy <search query>'
  end

  def regex
    /^\/pb\s+(?<num>.*)/i
  end

  def invoke!
    fridge = Fridge.find_by_token chat_id

    if fridge.nil?
      reply 'You need to search for products first,' \
            ' use */p <product name>*'
    else

      id = nil

      fridge.contents.each_with_index do |product, idx|
        id = product['id'] if (idx + 1) == match[:num].to_i
      end

      if id.nil?
        reply "I cannot find item with number #{match[:num]}," \
              ' did you enter the correct one?'
      else
        reply "I've placed the product in your shopping cart!\n" \
              "http://www.bol.com/nl/inwinkelwagentje.html?productId=#{id}"
      end
    end
  end
end
