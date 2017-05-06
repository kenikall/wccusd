class HomeController < ApplicationController
  def index
    # if current_user.has_role?(:student)
    #   redirect_to student_path(current_user) && return
    # elsif current_user.has_role?(:admin)
    #   redirect_to admin_path(current_user) && return
    # elsif current_user.has_role?(:teacher)
    #   redirect_to teacher_path(current_user) && return
    # end
  end
end
