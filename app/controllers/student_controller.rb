# frozen_string_literal: true

class StudentController < ApplicationController
  def show
    redirect_unless_role_is(:student)
    @student = current_user
  end
end
