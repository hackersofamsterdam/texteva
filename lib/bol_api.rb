require 'active_support/concern'

# Bol API
module BolAPI
  extend ActiveSupport::Concern

  included do
    include HTTParty
    base_uri 'api.bol.com'
  end

  def api_options
    { query: { apikey: 'E9D7DA0A32024A7AA6D618F452047479',
               format: 'json' } }
  end
end
