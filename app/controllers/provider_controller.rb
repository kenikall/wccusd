class ProviderController < ApplicationController
  def new
    redirect_to student_path(current_user) if current_user.is_student?
  end

  def create
    # @url = provider_params[:url]
    # valid_email = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
    # puts @url !~ valid_email
    # if @url !~ valid_email
    #   flash[:notice] = "This email must be in email format (example@email.com)."
    #   redirect_to new_provider_path and return
    # end

    @provider = Provider.new(provider_params)

    respond_to do |format|
      puts '@'*50
      puts user_dashboard_path_name
      puts '@'*50
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
