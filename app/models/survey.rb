class Survey < ApplicationRecord
  belongs_to :user
  belongs_to :event

  def activate_survey
    event = Event.find(event_id)
    event.date.change({ year: event.date.year, month: event.date.month, day: event.date.day, hour: 6 })
  end

  def deactivate_survey
    event = Event.find(event_id)
    event.date.change({ year: event.date.year, month: event.date.month, day: event.date.day, hour: 18 })
  end

  def teacher
    User.find(Event.find(event_id).teacher_id)
  end

  def student_questions
    [
      "Was this event connected to something you're learning about in class?",
      "Do you have a better sense of jobs and skills related to your pathway as a result of this event?",
      "Did this event help you think about what you may or may not want to do in the future?",
      "Did the event help you to gain confidence in talking with professionals?",
      "Do have any comments or suggestions for improving this event?"
    ]
  end

  def teacher_questions
    [
      "Was this event connected to something you are teaching in the classroom?",
      "What learning outcomes was the event designed to build?",
      "Do you feel the event was successful in meeting those learning outcomes for students?",
      "Do have any comments or suggestions regarding how this event could be improved?",
    ]
  end

  def teacher_question2_options
      {
        career_awareness: "Build career awareness",
        workplace_protocols: "Learn workplace protocols, culture, and safety",
        field_interest: "Experience a field of interest",
        career_skills: "Learn career-based skills",
        gain_confidence: "Gain confidence and skill communicating with professionals",
        project: "Develop industry-based skills through project",
        creative_thinking: "Engage in creative thinking/Innovation",
        teamwork_skills: "Collaboration and teamwork skills",
        take_feedback: "Learn how to take feedback",
        self_management: "Self-management",
        assess_learning: "Reflect on and assess own learning",
        develop_plan: "Develop college & career plan"
      }
  end

  def learning_outcomes
    outcomes = []

    outcomes << "Build career awareness" if career_awareness
    outcomes << "Learn workplace protocols, culture, and safety" if workplace_protocols
    outcomes << "Experience a field of interest" if field_interest
    outcomes << "Learn career-based skills" if career_skills
    outcomes << "Gain confidence and skill communicating with professionals" if gain_confidence
    outcomes << "Develop industry-based skills through project" if project
    outcomes << "Engage in creative thinking/Innovation" if creative_thinking
    outcomes << "Collaboration and teamwork skills" if teamwork_skills
    outcomes << "Learn how to take feedback" if take_feedback
    outcomes << "Self-management" if self_management
    outcomes << "Reflect on and assess own learning" if assess_learning
    outcomes << "Develop college & career plan" if develop_plan

    outcomes
  end
end
