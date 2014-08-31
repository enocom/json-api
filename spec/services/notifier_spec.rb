require_relative "../../app/services/notifier"
require_relative "../../app/mailers/movie_notification_mailer"
require_relative "../../app/entities/movie_entity"

describe Notifier do
  it "sends notifications using a passed-in mailer" do
    entity = MovieEntity.new(title:     "Akira",
                             director:  "Katsuhiro Otomo",
                             fan_email: "tetsuo.shima@neo-tokyo.net")

    expect {
      Notifier.new.send_notification(entity)
    }.to change(ActionMailer::Base.deliveries, :count).by(1)
  end
end
