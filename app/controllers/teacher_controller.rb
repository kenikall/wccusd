# frozen_string_literal: true

class TeacherController < ApplicationController
  def show
    redirect_to student_path(current_user) if !current_user.is_teacher?

    if student_params[:student_id]
      @student = User.find_by(student_number: student_params[:student_id])
      if @student
        flash.clear
      else
        flash[:notice] = "Student number #{student_params[:student_id]} not found."
      end
    end

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

  def new
    redirect_to student_path(current_user) if !current_user.is_admin?
    @pathways = pathways()
    @schools = schools()
  end

  def create
    @teacher = User.new(teacher_params)
    @teacher.password = "change_password_immediately"
    @teacher.add_role(:teacher)
    respond_to do |format|
      if @teacher.save
        format.html { redirect_to user_dashboard_path_name, notice: "#{@teacher.name} was successfully created. Their password is '#{@teacher.password}'." }
        format.json { render :show, status: :created, location: @teacher }
      else
        format.html { render :new }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

private
  def pathway_param
    params.permit(:pathway)
  end

  def teacher_params
    params.permit(
                  :first_name,
                  :last_name,
                  :email,
                  :school,
                  :pathway,
                  :grade
      )

  end

  def student_params
    params.permit(:student_id)
  end
end
