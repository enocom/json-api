require "active_model"

class MovieEntity

  include ActiveModel::Serializers::JSON

  attr_reader :id, :title, :director

  def initialize(attributes)
    @id        = attributes[:id]
    @title     = attributes[:title]
    @director  = attributes[:director]
  end

  def attributes
    instance_values.symbolize_keys
  end

  def attributes=(hash)
    hash.each do |key, value|
      send("#{key}=", value)
    end
  end

end
