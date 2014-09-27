require "active_record"

class MovieDao < ActiveRecord::Base
  self.table_name = :movies

  validates_presence_of :title, :director
end
