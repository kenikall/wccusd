# frozen_string_literal: true

class AdminController < ApplicationController
  def show
    redirect_unless_role_is(:admin)

    @events = Event.all
    @pathways = pathways(current_user.school)
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
end
