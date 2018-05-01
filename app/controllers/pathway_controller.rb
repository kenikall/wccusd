# frozen_string_literal: true

class PathwayController < ApplicationController
  def new
    redirect_to student_path(current_user) unless current_user.is_admin?
    @schools = schools().flatten
  end

  def create
    puts "*****"
    puts params.inspect
    puts "*****"
    school_list = ""
    params[:schools].each do |school|
      school = school.gsub(/_/, " ")
      Pathway.create(school: school, path: params[:path])
      school_list += school_list.empty? ? school : ", #{school}"
    end

    redirect_to user_dashboard_path_name, notice: "The #{params[:path]} has been created for #{school_list}"
  end

private
  # def params
  #   params.permit(
  #                 :schools,
  #                 :path
  #                )
  # end
end

