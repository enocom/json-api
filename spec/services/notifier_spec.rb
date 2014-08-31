require_relative "../../app/services/notifier"
require_relative "../../app/mailers/movie_notification_mailer"
require_relative "../../app/entities/movie_entity"

describe Notifier do
  it "sends notifications using a passed-in mailer" do
    entity = MovieEntity.new(title:     "Akira",
                             director:  "Katsuhiro Otomo",
                             fan_email: "tetsuo.shima@neo-tokyo.net")
    mailer = class_double(MovieNotificationMailer)
    allow(mailer).to receive(:send_email)

    Notifier.new(mailer).send_notification(entity)

    expect(mailer).to have_received(:send_email).with(entity)
  end
end
