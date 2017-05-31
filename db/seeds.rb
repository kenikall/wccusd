Survey.destroy_all
Provider.destroy_all
Event.destroy_all
User.destroy_all

User.create(email: "person@example.com",    password: "123password!",
            first_name: "I should",
            last_name: "error")

ex_student = User.create(email: "student1@example.com", password: "123password!",
            first_name: "example1",
            school: "School1",
            last_name: "9th grader",
            grade: 9)
ex_student.add_role(:student)

("A".."Z").each do |id|
    (1..3).each do |num|
        User.create(email: "student9#{num}#{id}@example.com", password: "123password!",
                    first_name: "Freshman#{id}",
                    school: "School#{num}",
                    last_name: "School#{num}",
                    grade: 9).add_role(:student)
        User.create(email: "student10#{num}#{id}@example.com", password: "123password!",
                    first_name: "Sophmore#{id}",
                    school: "School#{num}",
                    last_name: "School#{num}",
                    grade: 10).add_role(:student)
        User.create(email: "student11#{num}#{id}@example.com", password: "123password!",
                    first_name: "Junior#{id}",
                    school: "School#{num}",
                    last_name: "School#{num}",
                    grade: 11).add_role(:student)
        User.create(email: "student12#{num}#{id}@example.com", password: "123password!",
                    first_name: "Senior#{id}",
                    school: "School#{num}",
                    last_name: "School#{num}",
                    grade: 12).add_role(:student)
    end
end

ex_teacher = User.create(email: "teacher1@example.com",   password: "123password!",
            first_name: "9th grade",
            last_name: "Teacher school1",
            school: "School1",
            grade: 9)
ex_teacher.add_role(:teacher)

User.create(email: "teacher2@example.com",   password: "123password!",
            first_name: "10th grade",
            last_name: "Teacher school2",
            school: "School2",
            grade: 10).add_role(:teacher)

User.create(email: "teacher3@example.com",   password: "123password!",
            first_name: "11th grade",
            last_name: "Teacher school3",
            school: "School3",
            grade: 11).add_role(:teacher)

User.create(email: "teacher4@example.com",   password: "123password!",
            first_name: "12th grade",
            last_name: "Teacher school4",
            school: "School3",
            grade: 12).add_role(:teacher)

User.create(email: "admin@example.com",     password: "123password!",
            first_name: "Ida",
            last_name: "Admin").add_role(:admin)

provider = Provider.create(name: "Sample Provider",
                location: "123 Example Street",
                url: "www.example.com",
                contact: "Jon Doe",
                phone: "123-567-8910",
                email: "email@email.com")

past_event = Event.create(school: ex_student.school,
             pathway: "pathway",
             activity: "activity",
             grade: ex_student.grade,
             provider_id: provider.id,
             # date: ,
             # start_time: ,
             # end_time: ,
             teacher_id: ex_teacher.id
            )

future_event = Event.create(school: ex_student.school,
             pathway: "pathway",
             activity: "activity",
             grade: ex_student.grade,
             provider_id: provider.id,
             # date: ,
             # start_time: ,
             # end_time: ,
             teacher_id: ex_teacher.id
            )


Survey.create(user_id: ex_student.id,
              event_id: past_event.id)
Survey.create(user_id: ex_student.id,
              event_id: future_event.id)
