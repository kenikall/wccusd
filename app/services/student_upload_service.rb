require 'csv'
require 'ostruct'
class StudentUploadService
  attr_reader :unsaved_students

  def process_file(uploaded_file)
    @count = 0
    @unsaved_students = []
    CSV.foreach(uploaded_file.path, headers: true) do |row|
      potential_student = {
        first_name: row[0],
        last_name: row[1],
        email: process_email(row[0], row[1]),
        student_number: row[2],
        school: row[4],
        grade: row[5],
        gender: row[6].downcase == "m" ? "male" : "female",
        ethnicity: process_ethnicity(row[7]),
        pathway: row[8]
      }
      save_student(potential_student)
    end
    @count
  end

  def save_student(potential_student)
    if potential_student[:student_number].blank?
      failed_save(potential_student, "Missing student number")
    elsif User.exists?(student_number: potential_student[:student_number])
      failed_save(potential_student, "Student with this number already exists")
    else
      student = User.new(email: potential_student[:email],
                         password: potential_student[:student_number],
                         first_name: potential_student[:first_name],
                         last_name: potential_student[:last_name],
                         school: potential_student[:school],
                         grade: potential_student[:grade],
                         gender: potential_student[:gender],
                         student_number: potential_student[:student_number],
                         ethnicity: potential_student[:ethnicity],
                         pathway: potential_student[:pathway]
                        )
      if student.save
        student.add_role(:student)
        @count += 1
      else
        failed_save(student)
      end
    end
  end

  def process_email(first_name, last_name)
    local_part = first_name.downcase.tr(" ", ".")+"."+last_name.downcase.tr(" ", ".")
    count = 1
    if User.exists?(email: "#{local_part}@wccusd.org")
      while User.exists?(email: "#{local_part + count.to_s}@wccusd.org")
        count += 1
      end
    end

    count > 0 ? "#{local_part + count.to_s}@wccusd.org" : "#{local_part}@wccusd.org"
  end

  def failed_save(student, reason="???")
    @unsaved_students << {
      id: student[:student_number],
      first_name: student[:first_name],
      last_name: student[:last_name],
      reason: reason
    }
  end

  def process_ethnicity(code)
    case code.to_s
    when "100" then "American Indian or Alaskan Native"
    when "201" then "Chinese"
    when "202" then "Japanese"
    when "203" then "Korean"
    when "204" then "Vietnamese"
    when "205" then "Asian Indian"
    when "206" then "Laotian"
    when "207" then "Cambodian"
    when "208" then "Hmong"
    when "299" then "Other Asian"
    when "301" then "Hawaiian"
    when "302" then "Guamanian"
    when "303" then "Samoan"
    when "304" then "Tahitian"
    when "399" then "Other Pacific Islander"
    when "400" then "Filipino"
    when "500" then "Hispanic/Latino"
    when "600" then "Black or African American"
    when "700" then "White"
    else "undefined"
    end
  end
end
