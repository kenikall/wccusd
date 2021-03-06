require 'csv'
# seed pathway
# Survey.destroy_all
# Provider.destroy_all
# Event.destroy_all
# *****
Pathway.destroy_all

%w(Law Health IT).each do |path|
    Pathway.create(school: "DeAnza High School", path: path)
end

%w(IT Media).each do |path|
    Pathway.create(school: "El Cerrito High School", path: path)
end

%w(IT Health).each do |path|
    Pathway.create(school: "Hercules High School", path: path)
end

%w(IT Welding).each do |path|
    Pathway.create(school: "Kennedy High School", path: path)
end

%w(Engineering Health Law Performing\ Arts).each do |path|
    Pathway.create(school: "Pinole Valley High School", path: path)
end

%w(Engineering Health Law Media Performing\ Arts\ Production).each do |path|
    Pathway.create(school: "Richmond High School", path: path)
end

# m = User.create(email: "kenikall@gmail.com",     password: "admin",
#             first_name: "Mannah",
#             last_name: "Kallon")
# m.add_role(:admin)

# User.create(email: "steves@urbanstrategies.org",     password: "change_password_immediately",
#             first_name: "Steve",
#             last_name: "Spiker").add_role(:admin)

# User.create(email: "sfabun@wccusd.net",     password: "change_password_immediately",
#             first_name: "Sean",
#             last_name: "Fabun",
#             school: "De Anza High School",
#             pathway: pathways.sample).add_role(:teacher)

# User.create(email: "do'shea@wccusd.net",     password: "change_password_immediately",
#             first_name: "Dan",
#             last_name: "O'Shea",
#             school: "Pinole Valley High School",
#             pathway: pathways.sample).add_role(:teacher)

# User.create(email: "mkadri@wccusd.net",     password: "change_password_immediately",
#             first_name: "Mary",
#             last_name: "Kardi",
#             school: "De Anza High School",
#             pathway: pathways.sample).add_role(:teacher)

# csv_text = File.read("/Users/manahkallon/sample_data.csv")
# csv = CSV.parse(csv_text, headers: true)
# csv.each do |row|
#   f_name = row[1].downcase.tr!(" ", "_") ? row[1].downcase.tr!(" ", "_") : row[1]
#   l_name = row[0].downcase.tr!(" ", "_") ? row[0].downcase.tr!(" ", "_") : row[0]
#   email = f_name+"_"+l_name+"@email.com"
#   i = 1


#   while User.find_by(email: email)
#     email = f_name+i+"_"+l_name+"@email.com"
#     i += 1
#   end

#   User.create!(email: f_name+"_"+l_name+"@email.com",
#             password: row[2],
#             first_name: row[0],
#             last_name: row[1],
#             school: row[4],
#             grade: row[5],
#             gender: row[6],
#             ethnicity: row[7],
#             student_number: row[2].to_i,
#             pathway: row[11]).add_role(:student)
# end

# fr_teach = User.create(email: "teacher1@example.com",   password: "123password!",
#             first_name: "9th grade teacher",
#             last_name: "@De Anza High School",
#             school: "De Anza High School",
#             pathway: pathways.sample,
#             grade: 9)
# fr_teach.add_role(:teacher)

# so_teach = User.create(email: "teacher2@example.com",   password: "123password!",
#             first_name: "10th grade teacher",
#             last_name: "@El Cerrito High School",
#             school: "El Cerrito High School",
#             pathway: pathways.sample,
#             grade: 10)
# so_teach.add_role(:teacher)

# seed pathway
# teach = User.create(email: "teacher@example.com",   password: "123password!",
#             first_name: "11th grade teacher",
#             last_name: "@Hercules High School",
#             school: "Hercules High School",
#             pathway: 'health',
#             grade: 11)
# teach.add_role(:teacher)

# ex = User.create(email: "admin@example.com",   password: "123password!",
#             first_name: "admin",
#             last_name: "@Vista High School",
#             school: "Vista High School",
#             pathway: "health",
#             grade: 12)
# ex.add_role(:admin)
# *****

#teachers = [fr_teach, so_teach, jr_teach, sr_teach]

# User.create(email: "admin@example.com",     password: "123password!",
#             first_name: "Ida",
#             last_name: "Admin").add_role(:admin)
# teachers = []
# User.all.each do |user|
#   teachers << user if user.is_teacher?
# end

# seed pathway
# google = Provider.create(
#                 first_name: "Jon",
#                 last_name: "Doe",
#                 title: "Engineer",
#                 organization: "google",
#                 location: "Googleplex",
#                 url: "https://careers.google.com/students/",
#                 phone: "123-567-8910",
#                 email: "email@email.com")
# apple = Provider.create(
#                 first_name: "Plain",
#                 last_name: "Jane",
#                 title: "Marketing Director",
#                 organization: "google",
#                 location: "Googleplex",
#                 url: "https://careers.google.com/students/",
#                 phone: "123-567-8910",
#                 email: "email@email.com")
# microsoft = Provider.create(
#                 first_name: "Jon",
#                 last_name: "Doe",
#                 title: "CEO",
#                 organization: "google",
#                 location: "Googleplex",
#                 url: "https://careers.google.com/students/",
#                 phone: "123-567-8910",
#                 email: "email@email.com")
# microsoft = Provider.create(
#                 first_name: "Lucy",
#                 last_name: "Tuchi",
#                 title: "Community Engagement Manager",
#                 organization: "apple",
#                 location: "Googleplex",
#                 url: "https://careers.google.com/students/",
#                 phone: "123-567-8910",
#                 email: "email@email.com")
# *****

# teachers.each do |teacher|

# seed pathway
#   Event.create( school: teach.school,
#                 pathway: "Health",
#                 activity: "Workplace Tour",
#                 grade: teach.grade,
#                 date: Time.now,
#                 teacher_id: teach.id,
#                 provider_id: apple.id,
#                 location: apple.location
#                 )
#   Event.create( school: teach.school,
#                 pathway: "Health",
#                 activity: "Mock Interviews",
#                 grade: teach.grade,
#                 date: Time.now+2.days,
#                 teacher_id: teach.id,
#                 provider_id: microsoft.id,
#                 location: microsoft.location
#                 )
#   Event.create( school: teach.school,
#                 pathway: "IT",
#                 activity: "Health",
#                 grade: teach.grade,
#                 date: Time.now-2.days,
#                 teacher_id: teach.id,
#                 provider_id: google.id,
#                 location: google.location
#                 )

  # User.all.each do |user|
  #   if user.is_student?
  #     Survey.create(user_id: user.id, complete: true, event_id: 7, question1: %w(yes no).sample, question2: %w(yes no).sample, question3: %w(yes no).sample, question4: %w(yes no).sample, survey_type: "student")
  #   end
  # end

  # Event.all.each do |event|
  #   Survey.create(event_id: event.id, survey_type: "partner")
  # end
# end
# *****
