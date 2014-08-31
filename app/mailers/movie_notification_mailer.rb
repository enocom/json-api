require "action_mailer"

class MovieNotificationMailer < ActionMailer::Base
  def new_listing(movie_entity)
    @director = movie_entity.director
    @title = movie_entity.title
    mail(to: movie_entity.fan_email, from: "new.listings@json-rails.rocks")
  end
end
