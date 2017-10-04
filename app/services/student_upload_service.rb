require 'csv'
require 'ostruct'
class StudentUploadService

  def process_file(uploaded_file)
    count = 0
    CSV.foreach(uploaded_file.path, headers: true) do |row|
      if row[0] && row[1]
        email = row[0].downcase.tr(" ", ".")+"."+row[1].downcase.tr(" ", ".")+"@email.com"
        puts email

        student = User.new(email: email,
                           password: row[2],
                           first_name: row[0],
                           last_name: row[1],
                           school: row[4],
                           grade: row[5],
                           gender: row[6],
                           student_number: row[2],
                           ethnicity: process_ethnicity(row[7]),
                           pathway: row[11])
        student.add_role(:student)
        count +=1 if student.save
      end
    end
    count
  end

  def process_ethnicity(code)
    case code
      when 100
        "one hundred"
      when 202
        "two hundred two"
      when 203
        "two hundred three"
      when 204
        "two hundred four"
      when 205
        "two hundred five"
      when 206
        "two hundred six"
      when 299
        "two hundred ninety nine"
      when 303
        "three hundred three"
      when 399
        "three hundred ninety nine"
      when 400
        "four hundred"
      when 500
        "five hundred"
      when 600
        "six hundred"
      when 700
        "seven hundred"
      else
        "undefined"
    end
  end
end
