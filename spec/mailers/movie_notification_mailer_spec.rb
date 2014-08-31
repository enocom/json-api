require "rails_helper"

describe MovieNotificationMailer do
  it "sends an email with the movie details" do
    entity = MovieEntity.new(title:     "Akira",
                             director:  "Katsuhiro Otomo",
                             fan_email: "tetsuo.shima@neo-tokyo.net")
    mail = MovieNotificationMailer.new_listing(entity)

    expect(mail.to).to eq ["tetsuo.shima@neo-tokyo.net"]
    expect(mail.body.raw_source).to include "Akira, directed by Katsuhiro Otomo"
  end
end