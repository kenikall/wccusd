User.destroy_all

User.create(email: "person@example.com",    password: "123password!",
            first_name: "I should",
            last_name: "error")

User.create(email: "student1@example.com", password: "123password!",
            first_name: "example1",
            school: "School1",
            last_name: "9th grader",
            grade: 9).add_role(:student)
User.create(email: "student2@example.com", password: "123password!",
            first_name: "example2",
            school: "School2",
            last_name: "9th grader",
            grade: 9).add_role(:student)
User.create(email: "student3@example.com", password: "123password!",
            first_name: "example3",
            school: "School3",
            last_name: "9th grader",
            grade: 9).add_role(:student)

User.create(email: "student4@example.com", password: "123password!",
            first_name: "example4",
            school: "School1",
            last_name: "10th grader",
            grade: 10).add_role(:student)
User.create(email: "student5@example.com", password: "123password!",
            first_name: "example5",
            school: "School2",
            last_name: "10th grader",
            grade: 10).add_role(:student)
User.create(email: "student6@example.com", password: "123password!",
            first_name: "example6",
            school: "School3",
            last_name: "10th grader",
            grade: 10).add_role(:student)

User.create(email: "student7@example.com", password: "123password!",
            first_name: "example7",
            school: "School1",
            last_name: "11th grader",
            grade: 11).add_role(:student)
User.create(email: "student8@example.com", password: "123password!",
            first_name: "example8",
            school: "School2",
            last_name: "11th grader",
            grade: 11).add_role(:student)
User.create(email: "student9@example.com", password: "123password!",
            first_name: "example9",
            school: "School3",
            last_name: "11th grader",
            grade: 11).add_role(:student)

User.create(email: "student10@example.com", password: "123password!",
            first_name: "example10",
            school: "School1",
            last_name: "12th grader",
            grade: 12).add_role(:student)
User.create(email: "student11@example.com", password: "123password!",
            first_name: "example11",
            school: "School2",
            last_name: "12th grader",
            grade: 12).add_role(:student)
User.create(email: "student12@example.com", password: "123password!",
            first_name: "example12",
            school: "School3",
            last_name: "12th grader",
            grade: 12).add_role(:student)

User.create(email: "teacher1@example.com",   password: "123password!",
            first_name: "9th grade",
            last_name: "Teacher school1",
            school: "School1",
            grade: 9).add_role(:teacher)

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
