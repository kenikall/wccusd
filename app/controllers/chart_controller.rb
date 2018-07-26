# frozen_string_literal: true

class ChartController < ApplicationController
  def index
    redirect_to student_path(current_user) unless current_user.is_admin?
    school = sanitized_params[:school] == "All" ? schools.flatten.first : sanitized_params[:school]
    grade = sanitized_params[:grade] == "All" ? 9 : sanitized_params[:grade]
    pathway = sanitized_params[:pathway] == "All" ? pathways(school).first : sanitized_params[:pathway]

    redirect_to chart_path(school: sanitized_params[:school],
                           grade: grade,
                           pathway: sanitized_params[:pathway],
                           id: current_user.id) if params[:chart_type] == "Participation"
    set_params
    @chart_data = @chart_type == "Activities" ? charted_activities : charted_learning_outcomes
  end

  def data
    chart_service = ChartService.new
    if params[:type] == "Participation"
      render json: chart_service.participation_chart(
        teacher: current_user,
        pathway: current_user).to_json
    end
  end

  def set_params
    @chart_types = ["Participation", "Learning Outcomes", "Activities"]
    @chart_type = sanitized_params[:chart_type]

    @schools = current_user.is_admin? ? ["All"] + schools.flatten : [current_user.school]
    @school = sanitized_params[:school] || @schools.first

    @pathways = current_user.is_admin? ? ["All"] +  Pathway.all.map(&:path).uniq.sort : pathways(current_user.school)
    @pathway = sanitized_params[:pathway] || @pathways.first

    @grades = ["All", 9, 10, 11, 12]
    @grade = sanitized_params[:grade] || @grades.last

    @title = "#{sanitized_params[:chart_type]} "
    @title += "#{sanitized_params[:school]} " if sanitized_params[:school] != 'All'
    @title += "#{sanitized_params[:grade]}th grade " if sanitized_params[:grade] != 'All'
    @title += "#{sanitized_params[:pathway]} " if sanitized_params[:pathway] != 'All'

    if sanitized_params[:pathway]
      @events = Event.where(school: sanitized_params[:school], pathway: sanitized_params[:pathway])
    else
      @events = Event.where(school: sanitized_params[:school])
    end
  end

  def show
    redirect_to student_path(current_user) if current_user.is_stuedent?
    @teacher = current_user
    @schools = @teacher.is_admin? ? schools.flatten : [current_user.school]
    @school = params[:school].gsub("_", " ")
    @pathways = @teacher.is_admin? ? pathways(schools.first) : ["all"] + pathways(current_user.school)
    @pathway = params[:pathway].gsub("_", " ")
    @grades = ["all", 9, 10, 11, 12]
    @grade = params[:grade]


    if params[:pathway]
      @events = Event.where(school: params[:school].gsub("_", " "), pathway: params[:pathway])
    elsif
      @events = Event.where(school: params[:school].gsub("_", " "))
    end

    current_school = params[:school]
    @students = []
    User.where(
      school: params[:school].gsub("_", " "),
      pathway: params[:pathway].gsub("_", " "),
      grade: params[:grade]
    ).each{|user| @students << user if user.is_student?}
    @students = @students.sort_by{|student| student.last_name}
  end
private

  def chart_params
    params.permit(
                  :chart_type,
                  :school,
                  :grade,
                  :pathway,
                  :id,
      )
  end

  def sanitized_params
    @sanitized_params ||= {
      chart_type: chart_params[:chart_type] ? chart_params[:chart_type].gsub("_", " ") : "Learning Outcomes",
      school: chart_params[:school] ? chart_params[:school].gsub("_", " ") : schools.flatten.first,
      pathway: chart_params[:pathway] ? chart_params[:pathway].gsub("_", " ") : pathways(schools.first),
      grade: chart_params[:grade] ? chart_params[:grade].to_i : 9,
      id: current_user.id,
    }
  end

  def activity_hash(activity, grade)
    conditional_hash = {}
    conditional_hash[:activity] = activity
    conditional_hash[:grade] = grade
    conditional_hash[:grade] = params[:grade] if params[:grade] && params[:grade] != 'All'
    conditional_hash[:school] = sanitized_params[:school] if sanitized_params[:school]  && sanitized_params[:school]  != 'All'
    conditional_hash[:pathway] = sanitized_params[:pathway] if sanitized_params[:pathway] && sanitized_params[:pathway] != 'All'
    conditional_hash
  end

  def charted_activities
    activities_hash = {}
    count = 0
    activities.flatten.each do |activity|
      count += 1
      activities_hash[activity] =
        {
          ninth: Event.where(activity_hash(activity, 9)).length,
          tenth: Event.where(activity_hash(activity, 10)).length,
          eleventh: Event.where(activity_hash(activity, 11)).length,
          twelfth: Event.where(activity_hash(activity, 12)).length,
          id: "q#{count}"
        }

    end
    activities_hash
  end

  def charted_learning_outcomes
    learning_outcomes_hash = {}
    count = 0
    learning_outcomes.each do |outcome|
      count += 1
      learning_outcomes_hash[outcome[1]] =         {
        ninth: 0,
        tenth: 0,
        eleventh: 0,
        twelfth: 0,
        id: "q#{count}"
      }
    end

    Survey.where(survey_type: "teacher").each do |survey|
      if (User.find(survey.user_id).grade == 11)
        puts "@@@@@"
        puts sanitized_params[:grade]
        puts User.find(survey.user_id).grade
        puts User.find(survey.user_id).grade == sanitized_params[:grade]
        puts "@@@@@"
      end
      next unless sanitized_params[:grade] == 'All' || sanitized_params[:grade].to_i == User.find(survey.user_id).grade.to_i
      next unless sanitized_params[:pathway] == 'All' || sanitized_params[:pathway] == User.find(survey.user_id).pathway
      next unless sanitized_params[:school] == 'All' || sanitized_params[:school] == User.find(survey.user_id).school

      learning_outcomes.keys.each do |outcome|
        learning_outcomes_hash[learning_outcomes[outcome]][:ninth] += 1 if Event.find(survey.event_id).grade == 9 && survey.public_send(outcome)
        learning_outcomes_hash[learning_outcomes[outcome]][:tenth] += 1 if Event.find(survey.event_id).grade == 10 && survey.public_send(outcome)
        learning_outcomes_hash[learning_outcomes[outcome]][:eleventh] += 1 if Event.find(survey.event_id).grade == 11 && survey.public_send(outcome)
        learning_outcomes_hash[learning_outcomes[outcome]][:twelfth] += 1 if Event.find(survey.event_id).grade == 12 && survey.public_send(outcome)
      end
    end

    learning_outcomes_hash
  end
end
