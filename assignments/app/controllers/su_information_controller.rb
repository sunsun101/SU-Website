class SuInformationController < ApplicationController
  def index
    @su_member = SuMember.new 
    @su_members = SuMember.all
  end
  def create 
    @su_member = SuMember.new(su_member_params)
    respond_to do |format|
      if @su_member.save
        format.html { redirect_to su_information_path, notice: 'Project was successfully created.' }
        format.json { render :index, status: :created, location: su_information_path }
      else
        format.html { render :index, status: :unprocessable_entity }
        format.json { render json: su_information_path.errors, status: :unprocessable_entity }
      end
    end
  end
  private
    def su_member_params
      params.require(:su_member).permit(:first_name, :last_name, :designation, :nationality, :department, :program, :avatar)
    end
end
