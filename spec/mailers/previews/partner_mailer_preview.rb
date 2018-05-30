class PartnerMailerPreview < ActionMailer::Preview
  def event_email
    PartnerMailer.event_email(Provider.last, Event.first)
  end
end
