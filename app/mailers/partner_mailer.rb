class PartnerMailer < ActionMailer::Base
  default from: "need_an_email@example.com"

  def event_email(event)
    @event  = event
    @partner = Provider.find(@event.provider_id)
    @teacher = User.find(@event.teacher_id)
    @survey = Survey.find_by(survey_type: "partner", event_id: @event.id)

    mail(to: @partner.email, from: @teacher.email, subject: "#{@event.activity} with #{@event.school}")
  end
end
