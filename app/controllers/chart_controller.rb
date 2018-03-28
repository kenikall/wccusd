# frozen_string_literal: true

class ChartController < ApplicationController
  def show
    @events = Event.all
  end
end
