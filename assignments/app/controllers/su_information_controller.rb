class SuInformationController < ApplicationController
  def index
    @su_member = SuMember.new 
    @su_members = SuMember.all
  end
  def create 
    @su_member = SuMember.new(su_member_params)
    if @su_member.save
      flash[:notice] = "SU Member created successfully"
      redirect_to su_information_path
    else
      flash[:notice] = "Error in creating SU Member"
      redirect_to su_information_path
    end
  end
  private
    def su_member_params
      params.require(:su_member).permit(:first_name, :last_name, :designation, :nationality, :department, :program, :avatar)
    end
end
