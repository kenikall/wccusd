# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!

  def after_sign_in_path_for(resource)
    user_dashboard_path_name(resource)
  end

  def schools
    [
      ["El Cerrito High School"],
      ["Transition"],
      ["Hercules High School"],
      ["De Anza High School"],
      ["Sylvester Greenwood Academy"],
      ["Vista High Independent Study"],
      ["Gateway to College"],
      ["John F. Kennedy High School"],
      ["Pinole Valley High School"],
      ["Middle College High School"],
      ["Archive School"],
      ["Richmond High School"],
      ["Non Public Schools"],
      ["North Campus Continuation High"],
      ["Graduated Students"],
      ["Secondary Home Teaching"],
      ["Rich High School"],
    ]
  end

  def pathways
    [
      ["Legal Professions"],
      ["Law Enforcement"],
      ["Public Health"],
      ["Biomed"],
      ["Patient Care Emergency Medicine"],
      ["Civil & Software Engineering"],
      ["Civil Engineering"],
      ["Internet Engineering & Web Design"],
      ["Info Systems Mgmt & Web Design"],
      ["Digital Broadcast Journalism"],
      ["Production and Stagecraft"],
      ["Pacific Choral Academy"],
      ["Performance/Management"]
    ]
  end

  def user_dashboard_path_name(user = current_user)
    if user.is_student?
       student_path(user)
    elsif user.is_admin?
       admin_path(user)
    elsif user.is_teacher?
       teacher_path(user)
    end
  end

  def redirect_unless_role_is(role_name)
    unless current_user.has_role?(role_name) && current_user.id == params[:id].to_i
      redirect_to user_dashboard_path_name and return
    end
  end

end
