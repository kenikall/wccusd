require 'csv'
Survey.destroy_all
Provider.destroy_all
Event.destroy_all
User.destroy_all

pathways = [
      "Legal Professions",
      "Law Enforcement",
      "Public Health",
      "Biomed",
      "Patient Care Emergency Medicine",
      "Civil & Software Engineering",
      "Civil Engineering",
      "Internet Engineering & Web Design",
      "Info Systems Mgmt & Web Design",
      "Digital Broadcast Journalism",
      "Production and Stagecraft",
      "Pacific Choral Academy",
      "Performance/Management"
    ]
csv_text = File.read("/Users/manahkallon/sample_data.csv")
csv = CSV.parse(csv_text, headers: true)
csv.each do |row|
  f_name = row[1].downcase.tr!(" ", "_") ? row[1].downcase.tr!(" ", "_") : row[1]
  l_name = row[0].downcase.tr!(" ", "_") ? row[0].downcase.tr!(" ", "_") : row[0]
  email = f_name+"_"+l_name+"@email.com"
  i = 1


  while User.find_by(email: email)
    puts "looping"
    email = f_name+i+"_"+l_name+"@email.com"
    i += 1
  end

  puts email

  User.create!(email: f_name+"_"+l_name+"@email.com",
            password: row[2],
            first_name: row[0],
            last_name: row[1],
            school: row[4],
            grade: row[5],
            gender: row[6],
            ethnicity: row[7],
            student_number: row[2].to_i,
            pathway: row[11]).add_role(:student)
end

fr_teach = User.create(email: "teacher1@example.com",   password: "123password!",
            first_name: "9th grade teacher",
            last_name: "@De Anza High School",
            school: "De Anza High School",
            pathway: pathways.sample,
            grade: 9)
fr_teach.add_role(:teacher)

so_teach = User.create(email: "teacher2@example.com",   password: "123password!",
            first_name: "10th grade teacher",
            last_name: "@El Cerrito High School",
            school: "El Cerrito High School",
            pathway: pathways.sample,
            grade: 10)
so_teach.add_role(:teacher)

jr_teach = User.create(email: "teacher3@example.com",   password: "123password!",
            first_name: "11th grade teacher",
            last_name: "@Hercules High School",
            school: "Hercules High School",
            pathway: pathways.sample,
            grade: 11)
jr_teach.add_role(:teacher)

sr_teach = User.create(email: "teacher4@example.com",   password: "123password!",
            first_name: "12th grade teacher",
            last_name: "@Vista High School",
            school: "Vista High School",
            pathway: pathways.sample,
            grade: 12)
sr_teach.add_role(:teacher)

teachers = [fr_teach, so_teach, jr_teach, sr_teach]

User.create(email: "admin@example.com",     password: "123password!",
            first_name: "Ida",
            last_name: "Admin").add_role(:admin)

google = Provider.create(name: "Google",
                location: "Googleplex",
                url: "https://careers.google.com/students/",
                contact: "Jon Doe",
                phone: "123-567-8910",
                email: "email@email.com")
apple = Provider.create(name: "Apple",
                location: "Apple Infinite Loop",
                url: "https://www.apple.com/jobs/us/students.html",
                contact: "Jon Doe",
                phone: "123-567-8910",
                email: "email@email.com")
microsoft = Provider.create(name: "Microsoft",
                location: "1355 Market St",
                url: "https://careers.microsoft.com/students/internships",
                contact: "Jon Doe",
                phone: "123-567-8910",
                email: "email@email.com")

teachers.each do |teacher|
  Event.create( school: teacher.school,
                pathway: "Multimedia",
                activity: "Workplace Tour",
                grade: teacher.grade,
                date: Time.now,
                start_time: Time.now - 12.hours,
                teacher_id: teacher.id,
                end_time: Time.now - 10.hours,
                provider_id: apple.id,
                location: apple.location
                )
  Event.create( school: teacher.school,
                pathway: "Engineering",
                activity: "Mock Interviews",
                grade: teacher.grade,
                date: Time.now+2.days,
                start_time: Time.now,
                teacher_id: teacher.id,
                end_time: Time.now + 2.hours,
                provider_id: microsoft.id,
                location: microsoft.location
                )
  Event.create( school: teacher.school,
                pathway: "IT",
                activity: "Internship",
                grade: teacher.grade,
                date: Time.now-2.days,
                start_time: Time.now,
                teacher_id: teacher.id,
                end_time: Time.now + 2.hours,
                provider_id: google.id,
                location: google.location
                )
end

User.all.each do |user|
    Event.all.each do |event|
        if event.grade == user.grade
            Survey.create(user_id: user.id, event_id: event.id)
        end
    end
end
