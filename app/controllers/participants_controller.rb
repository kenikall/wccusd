class ParticipantsController < ApplicationController

  def index
    return if !current_user.is_teacher? && !current_user.is_admin?
    @participants = []

    User.all.each do |user|
      next if !user.is_student?

      if params[:grade] != "All" && params[:school] != "All"
        @participants << user if user.grade == params[:grade].to_i && user.school == params[:school]
      elsif params[:grade] != "All" && params[:school] == "All"
        @participants << user if user.grade == params[:grade].to_i
      elsif params[:grade] == "All" && params[:school] != "All"
        @participants << user if user.school == params[:school]
      else
        @participants << user
      end
    end
    puts "*"*50
    puts @participants.to_json
    puts "*"*50
    render json:@participants.to_json
  end
end
