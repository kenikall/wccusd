# frozen_string_literal: true

class PathwayController < ApplicationController
  def new
    redirect_to student_path(current_user) unless current_user.is_admin?
    @schools = schools()
    @pathway = Pathway.new
  end

  def create
    @pathway = Pathway.new(pathway_params)
    respond_to do |format|
      if @pathway.save
        format.html { redirect_to user_dashboard_path_name, notice: "The ___" }
        format.json { render :show, status: :created, location: @teacher }
      else
        format.html { render :new }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end
end

