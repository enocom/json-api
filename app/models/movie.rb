require "active_record"

class Movie < ActiveRecord::Base
  validates_presence_of :title, :director
end
