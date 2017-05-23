# frozen_string_literal: true

class EventController < ApplicationController
  def index
    # if user == teacher show only teacher events, else show all events
  end

  def new
    redirect_to student_path(current_user) if current_user.is_student?
    @students = []
    @schools = []

    User.all.each do |user|
        @schools << user.school
        next unless user.is_student?
        @students << user
    end
    @schools = @schools.uniq
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)

    respond_to do |format|
      # @event.users.each do |user|
      #   next unless user.is_student?
      #   @event.student_surveys << StudentSurvey.create(user: user)
      # end

      if @event.save
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

private
  def event_params
    # all the params for the form need to be here.
    params.require(:event).permit(:students)
  end
end
