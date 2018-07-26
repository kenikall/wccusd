class PartnerMailerPreview < ActionMailer::Preview
  def event_email
    PartnerMailer.event_email(Event.last)
  end
end
