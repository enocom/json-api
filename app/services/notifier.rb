class Notifier
  def initialize(mailer = MovieNotificationMailer)
    @mailer = mailer
  end

  def send_notification(movie_entity)
    if movie_entity && movie_entity.fan_email
      mailer.delay.new_listing(movie_entity)
    end
  end

  private

  attr_reader :mailer

end
