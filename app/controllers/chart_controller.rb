# frozen_string_literal: true

class ChartController < ApplicationController
  def index
    redirect_to student_path(current_user) unless current_user.is_admin?

    @schools = schools()
    @teachers
    # @grades = %w(9th 10th 11th 12th)
    @activites = charted_activities
  end

  def data
    chart_service = ChartService.new
    if params[:type] == "participation"
      render json: chart_service.participation_chart(
        teacher: current_user,
        pathway: current_user).to_json

    end
  end

  def show
    redirect_to student_path(current_user) if current_user.is_stuedent?
    @teacher = current_user
    @events = Event.where(teacher_id: @teacher.id).to_a
    @students = []
    User.all.each{|user| @students << user if is_in_class(user)}
    @events.each {|event| puts event.id}
  end
private
  def is_in_class(user)
    user.is_student? &&
    user.school == @teacher.school &&
    user.pathway == @teacher.pathway &&
    user.grade == @teacher.grade
  end

  def charted_activities
    activities_hash = {
      ninth: {},
      tenth: {},
      eleventh: {},
      twelfth: {}
    }
    activities.flatten.each do |activity|
      activities_hash[:ninth][activity] = Event.where(activity: activity, grade: 9).length
      activities_hash[:tenth][activity] = Event.where(activity: activity, grade: 10).length
      activities_hash[:eleventh][activity] = Event.where(activity: activity, grade: 11).length
      activities_hash[:twelfth][activity] = Event.where(activity: activity, grade: 12).length
    end
    activities_hash
  end
end
