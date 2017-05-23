# frozen_string_literal: true

class SurveyController < ApplicationController
  def index
  end

  def show
    @survey = Survey.new
  end

  def update
    @survey = Survey.new(survey_params)

    respond_to do |format|
      if @survey.save
        format.html { redirect_to @survey, notice: "survey was successfully created." }
        format.json { render :show, status: :created, location: @survey }
      else
        format.html { render :new }
        format.json { render json: @survey.errors, status: :unprocessable_entity }
      end
    end
    # redirect_to student_path(current_user)
  end
end

private
  def survey_params
    # all the params for the form need to be here.
    params.require(:question1, :question2, :question3, :question4)
  end
end
