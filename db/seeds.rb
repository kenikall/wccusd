User.destroy_all

7.times do |num|
  Event.create(
    school: nil,
    pathway: nil,
    course: nil,
    grade: nil,
    ninth_graders: 3,
    tenth_graders: 3,
    eleventh_graders: nil,
    twelfth_graders: nil,
    date: nil,
    duration: nil,
    )
end

User.create(email: "person@example.com",    password: "123password!")
User.create(email: "student@example.com", password: "123password!").add_role(:student)
User.create(email: "admin@example.com",     password: "123password!").add_role(:admin)
User.create(email: "teacher@example.com",   password: "123password!").add_role(:teacher)
