class NewTeacherMailer < ActionMailer::Base

  def new_teacher_email(teacher)
    @teacher = teacher
    @admin = User.find(2620)
    @password = "pleasechangethispassword"
    mail(to: @teacher.email, from: @admin.email, subject: "Your WCCUSD Work Based Learning APP Account")
  end
end