require 'csv'
require 'ostruct'
class StudentUploadService

  def process_file(uploaded_file)
    count = 0
    email_counter = 0
    CSV.foreach(uploaded_file.path, headers: true) do |row|
      if User.exists?(student_number: row[2])
      else
        if row[0] && row[1]
          email = row[1].downcase.tr(" ", ".")+"."+row[0].downcase.tr(" ", ".")
          new_email = email
          while User.exists?(email: "#{new_email}@email.com")
            email_counter +=1
            new_email += email+email_counter.to_s
          end
          new_email = 0
          email+="@wccusd.org"
          student = User.new(email: email,
                             password: row[2],
                             first_name: row[1],
                             last_name: row[0],
                             school: row[4],
                             grade: row[5],
                             gender: row[6],
                             student_number: row[2],
                             ethnicity: process_ethnicity(row[7]),
                             pathway: row[8])
          student.add_role(:student)
          count +=1 if student.save
        end
      end
    end
    count
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
