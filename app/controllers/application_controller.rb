# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!

  def after_sign_in_path_for(resource)
    user_dashboard_path_name(resource)
  end

  def schools
    [
      ["Archive School"],
      ["De Anza High School"],
      ["El Cerrito High School"],
      ["Gateway to College"],
      ["Graduated Students"],
      ["Hercules High School"],
      ["John F. Kennedy High School"],
      ["Middle College High School"],
      ["Non Public Schools"],
      ["North Campus Continuation High"],
      ["Pinole Valley High School"],
      ["Rich High School"],
      ["Richmond High School"],
      ["Secondary Home Teaching"],
      ["Sylvester Greenwood Academy"],
      ["Transition"],
      ["Vista High Independent Study"]
    ]
  end

  def pathways
    [
      ["Biomed"],
      ["Civil & Software Engineering"],
      ["Civil Engineering"],
      ["Digital Broadcast Journalism"],
      ["Info Systems Mgmt & Web Design"],
      ["Internet Engineering & Web Design"],
      ["Law Enforcement"],
      ["Legal Professions"],
      ["Pacific Choral Academy"],
      ["Patient Care Emergency Medicine"],
      ["Performance/Management"],
      ["Production and Stagecraft"],
      ["Public Health"],
    ]
  end

  def activities
    [
      ["Authentic Pathway Project"],
      ["Career Video"],
      ["College & Career Plan"],
      ["College Visit with Pathway Component"],
      ["Financial Literacy Activity"],
      ["Guest Speaker"],
      ["Industry Certification"],
      ["Industry Partner Help in Classroom"],
      ["Industry Partner Review of Project"],
      ["Industry-related Competition"],
      ["Internship"],
      ["Interview a Professional"],
      ["Mentoring Session"],
      ["Mock Interviews"],
      ["Online Career Exploration"],
      ["Resume Writing"],
      ["Reverse Job Shadow"],
      ["Senior Defense of Pathway Outcomes"],
      ["Student-run Enterprise or Performance"],
      ["Workplace Experiential Visit"],
      ["Workplace Tour"],
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
