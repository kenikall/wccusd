# frozen_string_literal: true

class StudentController < ApplicationController
  def show
    redirect_unless_role_is(:student)
    @upcoming_events = []
    @incomplete_surveys = []
    @complete_surveys = []
    Survey.all.each do |survey|
      next unless survey.user_id == current_user.id

      @upcoming_events << survey.event if survey.
      @incomplete_surveys << survey.event
      @complete_surveys << survey.event
    end
  end

  def create

  end
end
