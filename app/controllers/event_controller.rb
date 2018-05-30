# frozen_string_literal: true

class EventController < ApplicationController
  def index
    redirect_to student_path(current_user) if current_user.is_student?
    if current_user.is_teacher?
      @events = Event.where(teacher_id: current_user.id)
    else
      @events = Event.all
    end

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

  def new
    redirect_to student_path(current_user) if current_user.is_student?
    @grades = [["9th", 9],["10th", 10],["11th", 11],["12th", 12],["13th", 13],["All","All"]]

    @schools = schools()
    @partners = partners()
    @activities = activities()
    @pathways = pathways(current_user.school)
    @students = students(current_user)
    @teachers = teachers(current_user)

    @event = Event.new
  end

  def create
    @students = student_params[:students]
    if @sudents && @students.length == 0
      flash[:notice] = "You must add students to create an event."
      redirect_to new_event_path and return
    end
    @teacher_id = event_params[:teacher_id]
    @event = Event.new(event_params)

    @students.each do |student|
      student = User.find(student)
      @event.ninth_graders += 1 if student.grade == 9
      @event.tenth_graders += 1 if student.grade == 10
      @event.eleventh_graders += 1 if student.grade == 11
      @event.twelfth_graders += 1 if student.grade == 12
    end

    respond_to do |format|

      if @event.save
        Survey.create(user_id: @teacher_id, event_id: @event.id, survey_type: "teacher")
        Survey.create(event_id: @event.id, survey_type: "partner")
        P
        @students.each{|student_id| Survey.create(user_id: student_id, event_id: @event.id, survey_type: "student")}
        format.html { redirect_to @event, notice: "event was successfully created." }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    if current_user.is_teacher?
      redirect_to teacher_path(current_user)
    elsif current_user.is_admin?
      redirect_to admin_path(current_user)
    end
  end

  def edit
    redirect_to student_path(current_user) if current_user.is_student?
    @event = Event.find(params[:id])
    @students = []
    @grades = [["9th", 9],["10th", 10],["11th", 11],["12th", 12],["13th", 13],["All","All"]]
    @teachers = [[User.find(@event.teacher_id).name, @event.teacher_id]]
    @partners = partners()
    @activities = activities()
    @pathways = pathways(current_user.school)

    User.all.each do |user|
        @teachers << [user.name, user.id] if user.is_teacher?
        if user.school == @event.school && user.grade == @event.grade
          @students << user if user.is_student?
        end
    end
    @teachers = @teachers.uniq
    @schools = schools()
    @current_students = []
    surveys = Survey.where(event_id: @event.id)
    surveys.each{ |survey| @current_students << User.find(survey.user_id) }
  end

  def update
    @event = Event.find(params[:id])
    @event.update(event_params){|key,v1| f(v1)}

    respond_to do |format|
      if @event.save
        format.html { redirect_to student_path(current_user), notice: "event was successfully created." }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

private
  def event_params
    params.permit(:school,
                  :pathway,
                  :activity,
                  :grade,
                  :teacher_id,
                  :provider_id,
                  :category,
                  :date,
                  :location,
                  )
  end

  def date_params
    params.permit(:date)
  end

  def student_params
    params.permit(students: [])
  end
end
