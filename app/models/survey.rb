class Survey < ApplicationRecord
  belongs_to :user
  belongs_to :event

  def activate_survey
    event = Event.find(event_id)
    event.end_time.change({ year: event.date.year, month: event.date.month, day: event.date.day })-30.minutes
  end
end
