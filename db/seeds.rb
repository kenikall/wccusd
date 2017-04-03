User.destroy_all

Teacher.create(
  email: 'email@email.com',
  first_name: 'f_name',
  last_name: 'l_name',
  password: 'password',
  school: 'school',
  grade: 9,
  password_hint: 'hint',
  access_level: 'teacher'
  )

10.times do |num|
  Student.create(
    email: "email#{num}@email.com",
    first_name: 'Student',
    last_name: num,
    password: 'password',
    school: 'school',
    grade: 9,
    password_hint: 'hint',
    access_level: 'student'
    )
end
