class ExampleMailerPreview < ActionMailer::Preview
  def example_email_test
    ExampleMailer.with(Event.first, Partner.last).event_email
  end
end
