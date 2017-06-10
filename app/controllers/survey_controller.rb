# frozen_string_literal: true

class SurveyController < ApplicationController
  def index
    redirect_to student_path(current_user) if current_user.is_student?
    @event = Event.find(params[:event_id])
    surveys = Survey.where(event_id: @event.id)
    process_surveys(surveys)
  end

  def show
    @survey = Survey.new
  end

  def edit
    @survey = Survey.find(params[:id])
  end

  def update
    @survey = Survey.find(params[:id])
    @survey.update(survey_params){|key,v1| f(v1)}
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

private
  def survey_params
    params.require(:survey).permit(:question1,
                  :question2,
                  :question3,
                  :question4,
                  :question5)
  end

  def process_surveys(surveys)
    @results = { complete: 0,
                 quest1_agg: 0,
                 quest2_agg: 0,
                 quest3_agg: 0,
                 quest4_agg: 0,
                 quest5_ary: []
               }

    surveys.each do |survey|
      @results[:complete] += 1 if survey.complete
      @results[:quest1_agg] += 1 if survey.question1 == "Yes"
      @results[:quest2_agg] += 1 if survey.question1 == "Yes"
      @results[:quest3_agg] += 1 if survey.question1 == "Yes"
      @results[:quest4_agg] += 1 if survey.question1 == "Yes"
      @results[:quest5_ary] << [User.find(survey.user_id).name, survey.question5] if survey.question5
    end
    @results[:total] = surveys.length
  end
end
