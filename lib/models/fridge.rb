# Fridge
class Fridge < Ohm::Model
  attribute :chat_id
  attribute :contents_data

  index :chat_id

  def contents=(data)
    self.content_data = MultiJson.dump data
  end

  def contents
    MultiJson.load content_data
  end

  def find_by_chat_id(chat_id)
    find(chat_id: chat_id).first
  end
end
