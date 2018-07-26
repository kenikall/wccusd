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
    @grades = current_user.lead? ? [["9th", 9],["10th", 10],["11th", 11],["12th", 12],["13th", 13],["All","All"]] : [current_user.grade]

    @schools = schools()
    @partners = []
    Provider.where(school: current_user.school).each{|partner| @partners << ["#{partner.first_name} #{partner.last_name}", partner.id]}
    @activities = activities()
    @pathways = current_user.lead? ? pathways(current_user.school) : [current_user.pathway]
    @students = students(current_user)
    @teachers = current_user.lead? ? ([[current_user.name, current_user.id]] + teachers(current_user.school)).uniq : [[current_user.name, current_user.id]]

    @event = Event.new
  end

  def create
    @students = student_params[:students]
    if @sudents && @students.length == 0
      flash[:notice] = "You must add students to create an event."
      redirect_to new_event_path and return
    end
    @teacher = User.find(event_params[:teacher_id])
    @event = Event.new(event_params)

    respond_to do |format|

      if @event.save
        flash[:notice] = "Event was successfully created."
        Survey.create(user_id: @teacher.id, event_id: @event.id, survey_type: "teacher")
        Survey.create(event_id: @event.id, survey_type: "partner")
        PartnerMailer.event_email(@event).deliver_later(wait_until: @event.date)
        @students.each{|student_id| Survey.create(user_id: student_id, event_id: @event.id, survey_type: "student")}
        format.html { redirect_to controller: "teacher", action: "show", id: current_user.id }
        format.json { render :show, status: :created, location: @teacher }
      else
        format.html { render :new }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    @event = Event.find(params[:id])
    @teacher = User.find(@event.teacher_id)
    partner = Provider.find(@event.provider_id)
    @partner_name = "#{partner.first_name} #{partner.last_name} #{partner.title ? partner.title : ''} #{partner.organization ? 'at '+partner.organization : ''}"
    @students = []
    #Survey.where(event_id: @event.id).each{|survey| @students << User.find(survey.user_id) if User.find(survey.user_id).is_student?}
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
