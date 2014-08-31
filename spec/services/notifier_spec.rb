require "rails_helper"
require "sidekiq/testing"

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
