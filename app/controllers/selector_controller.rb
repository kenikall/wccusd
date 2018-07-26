class SelectorController < ApplicationController

  def index
    return if current_user.is_student?
    params[:school]
    @participants = []
  end
end