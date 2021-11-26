class SuInformationController < ApplicationController
  before_action :set_su_member, only: %i[show edit update destroy]

  def index
    @su_members = SuMember.all
    @su_member = SuMember.new
    @su_members = @su_members.order(:created_at)
  end

  # GET /projects/1/edit
  def edit
    if @su_member.update(su_member_params)
      flash[:success] = 'SU Member updated successfully'
    else
      flash[:error] = 'Error in updating SU Member'
    end
    redirect_to su_information_path
  end

  def create
    @su_member = SuMember.new(su_member_params)
    if @su_member.save
      flash[:success] = 'SU Member created successfully'
    else
      flash[:error] = 'Error in creating SU Member'
    end
    redirect_to su_information_path
  end

  # DELETE /projects/1 or /projects/1.json
  def destroy
    @su_member.avatar&.purge
    flash[:success] = 'SU Member deleted successfully' if @su_member.destroy
    redirect_to su_information_path
  end

  private

  def set_su_member
    @su_member = SuMember.find(params[:su_member][:id])
  end

  def su_member_params
    params.require(:su_member).permit(:id, :first_name, :last_name, :designation, :nationality, :department, :program,
                                      :avatar)
  end
end
