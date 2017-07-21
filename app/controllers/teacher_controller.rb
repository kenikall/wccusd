# frozen_string_literal: true

class TeacherController < ApplicationController
  def show
    redirect_to student_path(current_user) if !current_user.is_teacher?

    @events = Event.where(teacher_id: current_user.id)
    @pathways = pathways()
    @upcoming_events = []
    @past_events = []
    @events.each do |event|
      if event.date.past?
        @past_events << event
      else
        @upcoming_events << event
      end
    end
    @past_events.sort_by{|event| event.date} if @past_events
    @upcoming_events.sort_by{|event| event.date} if @upcoming_events
  end

  def update
    redirect_to student_path(current_user) if !current_user.is_teacher?
    teacher = current_user
    teacher.pathway = params[:pathway]
    teacher.save
    redirect_to teacher_path(current_user)
  end
end

private
  def pathway_param
    params.permit(:pathway)
  end
