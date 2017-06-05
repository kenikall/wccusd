Survey.destroy_all
Provider.destroy_all
Event.destroy_all
User.destroy_all

schools = ["De Anza High School", "El Cerrito High School", "Hercules High School", "Vista High School"]
("A".."M").each do |id|
    (0..3).each do |num|
        User.create(email: "student9#{num}#{id}@example.com", password: "123password!",
                    first_name: "Freshman#{id}",
                    school: schools[num],
                    last_name: "@ #{schools[num]}",
                    grade: 9).add_role(:student)
        User.create(email: "student10#{num}#{id}@example.com", password: "123password!",
                    first_name: "Sophmore#{id}",
                    school: schools[num],
                    last_name: "@ #{schools[num]}",
                    grade: 10).add_role(:student)
        User.create(email: "student11#{num}#{id}@example.com", password: "123password!",
                    first_name: "Junior#{id}",
                    school: schools[num],
                    last_name: "@ #{schools[num]}",
                    grade: 11).add_role(:student)
        User.create(email: "student12#{num}#{id}@example.com", password: "123password!",
                    first_name: "Senior#{id}",
                    school: schools[num],
                    last_name: "@ #{schools[num]}",
                    grade: 12).add_role(:student)
    end
end

fr_teach = User.create(email: "teacher1@example.com",   password: "123password!",
            first_name: "9th grade teacher",
            last_name: "@De Anza High School",
            school: "De Anza High School",
            grade: 9)
fr_teach.add_role(:teacher)

so_teach = User.create(email: "teacher2@example.com",   password: "123password!",
            first_name: "10th grade teacher",
            last_name: "@El Cerrito High School",
            school: "El Cerrito High School",
            grade: 10)
so_teach.add_role(:teacher)

jr_teach = User.create(email: "teacher3@example.com",   password: "123password!",
            first_name: "11th grade teacher",
            last_name: "@Hercules High School",
            school: "Hercules High School",
            grade: 11)
jr_teach.add_role(:teacher)

sr_teach = User.create(email: "teacher4@example.com",   password: "123password!",
            first_name: "12th grade teacher",
            last_name: "@Vista High School",
            school: "Vista High School",
            grade: 12)
sr_teach.add_role(:teacher)

teachers = [fr_teach, so_teach, jr_teach, sr_teach]
# User.create(email: "admin@example.com",     password: "123password!",
#             first_name: "Ida",
#             last_name: "Admin").add_role(:admin)

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

# freshmen = User.where(grade: 9)
# sophmores = User.where(grade: 10)
# juniors = User.where(grade: 11)
# seniors = User.where(grade: 12)

User.all.each do |student|
    next if !student.is_student?
    Event.all.each do |event|
        if event.grade == student.grade
            Survey.create(user_id: student.id, event_id: event.id)
        end
    end
end

# sophmores.each do |student|
#     next if !student.is_student?
#     Event.all.each do |event|
#         Survey.create(user_id: student.id, event_id: event.id)
#     end
# end

# juniors.each do |student|
#     next if !student.is_student?
#     Event.all.each do |event|
#         Survey.create(user_id: student.id, event_id: event.id)
#     end
# end

# seniors.each do |student|
#     next if !student.is_student?
#     Event.all.each do |event|
#         Survey.create(user_id: student.id, event_id: event.id)
#     end
# end
