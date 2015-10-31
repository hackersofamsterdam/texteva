# BolClient
class BolClient
  include HTTParty
  base_uri 'api.bol.com'

  def initialize
    @options = { query: { apikey: 'E9D7DA0A32024A7AA6D618F452047479',
                          format: 'json' } }
  end

  def catalog(q)
    @options[:query].merge! q: q,
                            offset: 0,
                            limit: 1,
                            dataoutput: 'products,categories'

    self.class.get('/catalog/v4/search', @options)
  end
end
