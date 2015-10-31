# Fridge
class Fridge < Ohm::Model
  attribute :token
  attribute :contents_data

  index :token

  def contents=(data)
    self.content_data = MultiJson.dump data
  end

  def contents
    MultiJson.load content_data
  end

  def find_by_token(token)
    find(token: token).first
  end
end
