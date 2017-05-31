# frozen_string_literal: true

class EventController < ApplicationController
  def index
    redirect_to student_path(current_user) if current_user.is_student?
    if current_user.is_teacher?
      @events = Event.where(teacher_id: current_user.id)
    else
      @events = Event.all
    end
  end

  def new
    redirect_to student_path(current_user) if current_user.is_student?
    @students = []
    @grades = [["#{current_user.grade}th", current_user.grade ]]
    @grades += [["9th", 9],["10th", 10],["11th", 11],["12th", 12],["All","All"]]
    @grades = @grades.uniq

    @schools = [current_user.school]
    @teachers = [[current_user.name, current_user.id]]
    @providers = [[current_user.school, nil]]
    @activities = define_activities
    @pathways = define_pathways

    Provider.all.each do |provider|
      @providers << [provider.name, provider.id]
    end
    @providers = @providers.uniq

    User.all.each do |user|
        @schools << user.school if user.school
        @teachers << [user.name, user.id] if user.is_teacher?
        if user.school == current_user.school && user.grade == current_user.grade
          @students << user if user.is_student?
        end
    end
    @teachers = @teachers.uniq
    @schools = @schools.uniq
  end

  def create
    # render plain: [params.to_yaml, event_params.to_yaml] and return

    @event = Event.new(event_params)
    @students = student_params[:students]

    @students.each do |student|
      student = User.find(student)
      @event.ninth_graders += 1 if student.grade == 9
      @event.tenth_graders += 1 if student.grade == 10
      @event.eleventh_graders += 1 if student.grade == 11
      @event.twelfth_graders += 1 if student.grade == 12
    end

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
    params.permit(:school,
                  :pathway,
                  :activity,
                  :grade,
                  :teacher_id,
                  :provider_id,
                  :category,
                  :date,
                  :location,
                  :"end_time(1i)",
                  :"end_time(2i)",
                  :"end_time(3i)",
                  :"end_time(4i)",
                  :"end_time(5i)",
                  :"start_time(1i)",
                  :"start_time(2i)",
                  :"start_time(3i)",
                  :"start_time(4i)",
                  :"start_time(5i)",
                  )
  end

  def date_params
    params.permit(:date,
                  :start_time,
                  :end_time)
  end

  def student_params
    params.permit(students: [])
  end

  def define_activities
    [["Career Video"],
     ["Online Career Exploration"],
     ["College & Career Plan"],
     ["Guest Speaker"],
     ["Interview a Professional"],
     ["Reverse Job Shadow"],
     ["Workplace Tour"],
     ["Workplace Experiential Visit"],
     ["College Visit with Pathway Component"],
     ["Industry-related Competition"],
     ["Resume Writing"],
     ["Mock Interviews"],
     ["Mentoring Session"],
     ["Authentic Pathway Project"],
     ["Industry Partner Help in Classroom"],
     ["Industry Partner Review of Project"],
     ["Financial Literacy Activity"],
     ["Student-run Enterprise or Performance"],
     ["Senior Defense of Pathway Outcomes"],
     ["Industry Certification"],
     ["Internship"]]
  end

  def define_pathways
    [["Advanced Manufacturing"],
     ["Biosciences"],
     ["Engineering"],
     ["Health"],
     ["IT"],
     ["Law"],
     ["Multimedia"],
     ["Performing Arts (Choral)"],
     ["Performing Arts (Production/Stagecraft)"]]
  end
end
