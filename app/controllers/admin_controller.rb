# frozen_string_literal: true

class AdminController < ApplicationController
  def show
    redirect_unless_role_is(:admin)
  end
end
