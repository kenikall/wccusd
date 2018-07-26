# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!

  DEFAULT_PASSWORD = "pleasechangethispassword"

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
    ].sort
  end

  def pathways(school)
    return Pathway.all.map(&:path).uniq.sort if current_user.is_admin?
    current_paths = []
    Pathway.all.each{|pathway| current_paths << pathway.path if pathway.school == school}
    current_paths = %w(none\ for\ this\ school) if current_paths.empty?
    current_paths.sort
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
    ].sort
  end

  def learning_outcomes
    {
      career_awareness: "Build career awareness",
      workplace_protocols: "Learn workplace protocols, culture, and safety",
      field_interest: "Experience a field of interest",
      career_skills: "Learn career-based skills",
      gain_confidence: "Gain confidence and skill communicating with professionals",
      project: "Develop industry-based skills through project",
      creative_thinking: "Engage in creative thinking/Innovation",
      teamwork_skills: "Collaboration and teamwork skills",
      take_feedback: "Learn how to take feedback",
      self_management: "Self-management",
      assess_learning: "Reflect on and assess own learning",
      develop_plan: "Develop college & career plan"
    }
  end

  def partners
    Provider.all.map do |partner|
      ["#{partner.first_name} #{partner.last_name} #{partner.title ? partner.title : ''} #{partner.organization ? 'at '+partner.organization : ''}", partner.id]
    end
  end

  def teachers(school)
    teachers = []
    User.where(school: current_user.school).each do |user|
      teachers << [user.name, user.id] if user.is_teacher?
    end
    teachers.uniq.sort
  end

  def students(current_teacher)
    current_students = []
    potenial_students = current_user.lead? ? User.where(school: current_user.school) : User.where(school: current_user.school, pathway: current_user.pathway, grade: current_user.grade)
    potenial_students.each do |user|
      current_students << user if user.is_student?
    end
    current_students.sort_by{|student| student.last_name}
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

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    added_attrs = [:username, :email, :password, :password_confirmation, :remember_me]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end
end
