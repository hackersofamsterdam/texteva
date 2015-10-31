# Fridge
class Fridge < Ohm::Model
  attribute :token
  attribute :contents_data

  index :token

  def contents=(data)
    self.contents_data = MultiJson.dump data
  end

  def contents
    MultiJson.load contents_data
  end

  def self.find_by_token(token)
    find(token: token).first
  end

  def self.find_or_initialize(query)
    find(query).first || self.class.new(query)
  end
end
