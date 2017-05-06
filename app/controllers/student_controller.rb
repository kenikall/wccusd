class StudentController < ApplicationController
  def show
    unless current_user.has_role?(:student) && current_user.id == params[:id].to_i
      redirect_to user_dashboard_path_name and return
    end
  end
end
