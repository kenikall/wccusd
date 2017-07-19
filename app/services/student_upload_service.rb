require 'csv'
require 'ostruct'
class StudentUploadService

  def process_file(uploaded_file)
    CSV.foreach(uploaded_file, headers: true) do |row|
      email = row[1].downcase!.tr!(" ", "_")+"_"+row[0].downcase!.tr!(" ", "_")

      User.create(email: email,
                password: row[2],
                first_name: row[0],
                last_name: row[1],
                school: row[4],
                grade: row[5],
                gender: row[6],
                ethnicity: process_ethnicity(row[7]),
                pathway: row[11]).add_role(:student)
    end
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

  def process_batch_build(ids)
    clearancing_status = create_clearancing_status
    ids.each{ |id| clearancing_status.item_ids_to_clearance << id }
    clearance_items!(clearancing_status)
  end
end
