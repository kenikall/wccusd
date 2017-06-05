# frozen_string_literal: true

class SurveyController < ApplicationController
  def index
  end

  def show
    @survey = Survey.new
  end

  def edit
    @survey = Survey.find(params[:id])
  end

  def update
    @survey = Survey.find(params[:id])
    ap survey_params
    @survey.update(survey_params){|key,v1| f(v1)}
    ap @survey

    if @survey.question1 && @survey.question2 && @survey.question3 && @survey.question4
      @survey.complete = true
    end

    respond_to do |format|
      if @survey.save
        format.html { redirect_to student_path(current_user), notice: "survey was successfully created." }
        format.json { render :show, status: :created, location: @survey }
      else
        format.html { render :new }
        format.json { render json: @survey.errors, status: :unprocessable_entity }
      end
    end
  end
end

private
def survey_params
  params.require(:survey).permit(:question1,
                :question2,
                :question3,
                :question4,
                :question5)
end
