# frozen_string_literal: true

class TeacherController < ApplicationController
  def show
    redirect_unless_role_is(:teacher)
  end
end
