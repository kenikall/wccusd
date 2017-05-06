class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!

  def after_sign_in_path_for(resource)
    user_dashboard_path_name(resource)
    # if resource.has_role?(:student)
    #    student_path(resource)
    # elsif resource.has_role?(:admin)
    #    admin_path(resource)
    # elsif resource.has_role?(:teacher)
    #    teacher_path(resource)
    # end
  end

  def user_dashboard_path_name(user = current_user)
    if user.has_role?(:student)
       student_path(user)
    elsif user.has_role?(:admin)
       admin_path(user)
    elsif user.has_role?(:teacher)
       teacher_path(user)
    end
  end
end
