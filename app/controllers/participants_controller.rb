class ParticipantsController < ApplicationController

  def index
    return if !current_user.is_teacher? && !current_user.is_admin?
    @participants = []

    User.all.each do |user|
      next if !user.is_student?


      if params[:grade] != "All" && params[:pathway] != "All" && params[:school] != "All"
        @participants << user if user.grade == params[:grade].to_i &&
                              user.pathway == params[:pathway] &&
                              user.school == params[:school]
        puts "grade: #{user.grade}, pathway: #{user.pathway}, school: #{user.school} #{@participants}"

      elsif params[:grade] != "All" && params[:pathway] == "All" && params[:school] == "All"
        @participants << user if user.grade == params[:grade].to_i
      elsif params[:grade] == "All" && params[:pathway] != "All" && params[:school] == "All"
        @participants << user if user.pathway == params[:pathway]
      elsif params[:grade] == "All" && params[:pathway] == "All" && params[:school] != "All"
        @participants << user if user.school == params[:school]

      elsif params[:grade] != "All" && params[:pathway] != "All" && params[:school] == "All"
        @participants << user if user.grade == params[:grade].to_i && user.pathway == params[:pathway]
      elsif params[:grade] != "All" && params[:pathway] == "All" && params[:school] != "All"
        @participants << user if user.grade == params[:grade].to_i && user.school == params[:school]
      elsif params[:grade] == "All" && params[:pathway] != "All" && params[:school] != "All"
        @participants << user if user.pathway == params[:pathway] && user.school == params[:school]
      else
        @participants << user
      end
    end

    render json:@participants.to_json
  end
end
