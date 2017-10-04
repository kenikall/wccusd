class PartnerMailer < ApplicationMailer
  default from: "need_an_email@example.com"

  def event_email(partner, event)
    @partner = partner
    @event  = event
    @teacher = User.find(@event.teacher_id)

    mail(to: @partner.email, subject: "#{@event.activity} with #{@event.school}")

  end
end
`
