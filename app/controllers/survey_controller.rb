# frozen_string_literal: true

class SurveyController < ApplicationController
  skip_before_action :authenticate_user!, :only => [:edit, :update]

  def index
    redirect_to student_path(current_user) if current_user.is_student?
    @event = Event.find(params[:event_id])
    @provider = Provider.find(@event.provider_id)
    @teacher_survey = Survey.where(user_id: @event.teacher_id).first
    surveys = Survey.where(event_id: @event.id, survey_type: "student")

    if Survey.where(event_id: @event.id, survey_type: "student", complete: true).length > 0
      @student_questions = surveys[0].student_questions
      @survey_data = process_surveys(surveys)
      @data = GraphingService.new.all_graph(surveys)
    end
  end

  def new
    @survey = Survey.new
  end

  def show
    @survey = Survey.find(params[:id])
    @event = Event.find(@survey[:event_id])
    @provider = Provider.find(@event.provider_id)
  end

  def edit
    @survey = Survey.find(params[:id])
    @event = Event.find(@survey[:event_id])
    sign_out(current_user) if user_signed_in? && @survey.survey_type == "partner"
  end

  def update
    @survey = Survey.find(params[:id])
    @survey.update(survey_params){|key,v1| f(v1)}
    if ((@survey.survey_type == "student" && @survey.question1 && @survey.question2 && @survey.question3 && @survey.question4) ||
      (@survey.survey_type == "teacher" && (@survey.question1 || @survey.question2 || @survey.question3 || @survey.question4)) ||
      (@survey.survey_type == "partner" && (@survey.question1 || @survey.question2 || @survey.question3)))

      @survey.complete = true
      flash[:success] = "Thank you for completing the survey!"
    else
      flash[:error] = "The survey you have just taken is incomplete, it has not been submitted"
    end

    respond_to do |format|
      if @survey.save
        if @survey.survey_type == "partner"
          format.html { redirect_to new_complete_path, notice: "survey was successfully created." }
        elsif @survey.survey_type == "student"
          format.html { redirect_to user_dashboard_path_name }
          format.json { render :show, status: :created, location: @survey }
        else
          format.html { redirect_to user_dashboard_path_name, notice: "survey was successfully created." }
          format.json { render :show, status: :created, location: @survey }
        end
      else
        format.html { render :new }
        format.json { render json: @survey.errors, status: :unprocessable_entity }
      end
    end
  end

  def complete
  end

private
  def survey_params
    params.require(:survey).permit(:question1,
                  :question2,
                  :question3,
                  :question4,
                  :question5,
                  :career_awareness,
                  :workplace_protocols,
                  :field_interest,
                  :career_skills,
                  :gain_confidence,
                  :project,
                  :creative_thinking,
                  :teamwork_skills,
                  :take_feedback,
                  :self_management,
                  :assess_learning,
                  :develop_plan,)
  end

  def process_surveys(surveys)
    @results = { complete: 0,
                 quest1_agg: 0,
                 quest2_agg: 0,
                 quest3_agg: 0,
                 quest4_agg: 0,
                 quest5_ary: [],
                 total: surveys.length
               }

    surveys.each do |survey|
      user = User.find(survey.user_id)
      survey.complete ? @results[:complete] += 1 : next
      @results[:quest1_agg] += 1 if survey.question1.downcase == "yes"
      @results[:quest2_agg] += 1 if survey.question2.downcase == "yes"
      @results[:quest3_agg] += 1 if survey.question3.downcase == "yes"
      @results[:quest4_agg] += 1 if survey.question4.downcase == "yes"
      @results[:quest5_ary] << [user.name, survey.question5] if survey.question5
    end
    @results
  end
end
