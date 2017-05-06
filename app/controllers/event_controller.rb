class EventController < ApplicationController
  def new
    @event = Event.new
    @teacher = User.first
  end

  def index
    # if user == teacher show only teacher events, else show all events
  end
end
