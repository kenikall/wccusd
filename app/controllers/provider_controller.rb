class ProviderController < ApplicationController
  def new
    redirect_to student_path(current_user) if current_user.is_student?
  end

  def create
    @provider = Provider.new(provider_params)

    respond_to do |format|
      if @provider.save
        format.html { redirect_to user_dashboard_path_name, notice: "#{@provider.organization} was successfully created." }
        format.json { render :show, status: :created, location: @provider }
      else
        format.html { render :new }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

private
  def provider_params
    params.permit(
                  :name,
                  :location,
                  :url,
                  :contact,
                  :phone,
                  :email
                 )
  end
end
