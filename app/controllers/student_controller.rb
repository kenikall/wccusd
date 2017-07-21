# frozen_string_literal: true

class StudentController < ApplicationController
  def show
    redirect_unless_role_is(:student)
    @upcoming_events = []
    @incomplete_surveys = []
    @complete_surveys = []
    Survey.all.each do |survey|
      next unless survey.user_id == current_user.id

      if survey.complete
        @complete_surveys << survey.event
      elsif survey.activate_survey > DateTime.now
        @upcoming_events << survey.event
      else
        @incomplete_surveys << survey.event
      end
     @upcoming_events.sort_by{|event| event.date} if @pcoming_events
     @complete_events.sort_by{|event| event.date} if @complete_events
     @incomplete_events.sort_by{|event| event.date} if @incomplete_events
    end
  end

  def create

  end
end
