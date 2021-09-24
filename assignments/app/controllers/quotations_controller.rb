class QuotationsController < ApplicationController
  before_action :set_quotation, only: %i[show edit update destroy]

  # GET /quotations or /quotations.json
  def index
    @quotations = Quotation.all
  end

  # GET /quotations/1 or /quotations/1.json
  def show; end

  # GET /quotations/new
  def new
    @quotation = Quotation.new
  end

  # GET /quotations/1/edit
  def edit; end

  # POST /quotations or /quotations.json
  def create
    #@quotation = Quotation.new(quotation_params)

    #respond_to do |format|
      #if @quotation.save
        #format.html { redirect_to @quotation, notice: 'Quotation was successfully created.' }
        #format.json { render :show, status: :created, location: @quotation }
      #else
        #format.html { render :new, status: :unprocessable_entity }
        #format.json { render json: @quotation.errors, status: :unprocessable_entity }
      #end
      if params[:quotation]
        @quotation = Quotation.new( params[:quotation] )
        if @quotation.save
          flash[:notice] = 'Quotation was successfully created.'
          @quotation = Quotation.new
        end
      else
        @quotation = Quotation.new
      end
      if params[:sort_by] == "date"
        @quotations = Quotation.order(:created_at)
      else
        @quotations = Quotation.order(:category)
      end
    end
  

  # PATCH/PUT /quotations/1 or /quotations/1.json
  def update
    respond_to do |format|
      if @quotation.update(quotation_params)
        format.html { redirect_to @quotation, notice: 'Quotation was successfully updated.' }
        format.json { render :show, status: :ok, location: @quotation }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @quotation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /quotations/1 or /quotations/1.json
  def destroy
    @quotation.destroy
    respond_to do |format|
      format.html { redirect_to quotations_url, notice: 'Quotation was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_quotation
    @quotation = Quotation.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def quotation_params
    params.require(:quotation).permit(:author_name, :cateory, :quote)
  end
end
