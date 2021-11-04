class ContactController < ApplicationController
  before_action :has_user
  def form
    @complain = Complain.new
  end

  def create
    @complain = Complain.new(complain_params)
    if @complain.save
      flash[:success] = 'complain created successfully'
      redirect_to contact_form_path
    else
      render :form
    end
  end

  private

  def complain_params
    params.require(:complain).permit(:user_id, :tag_id, :detail, :status, :subject, com_pics: [])
  end

  def has_user
    redirect_to(new_user_registration_path) unless current_user
  end
end
