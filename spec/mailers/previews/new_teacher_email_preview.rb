class PartnerMailerPreview < ActionMailer::Preview
  def new_teacher_email
    NewTeacherMailer.new_teacher_email(User.find(2619))
  end
end
