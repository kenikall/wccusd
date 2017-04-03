class EventController < ApplicationController
  def new
    @event = Event.new
  end
end
