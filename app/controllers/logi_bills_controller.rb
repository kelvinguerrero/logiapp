class LogiBillsController < ApplicationController
  before_action :set_logi_bill, only: [:show, :edit, :update, :destroy]

  # GET /logi_bills
  # GET /logi_bills.json
  def index
    @logi_bills = LogiBill.all
  end

  # GET /logi_bills/1
  # GET /logi_bills/1.json
  def show
  end

  # GET /logi_bills/new
  def new
    @logi_bill = LogiBill.new
  end

  # GET /logi_bills/1/edit
  def edit
  end

  # POST /logi_bills
  # POST /logi_bills.json
  def create
    @logi_bill = LogiBill.new(logi_bill_params)

    respond_to do |format|
      if @logi_bill.save
        format.html { redirect_to @logi_bill, notice: 'Logi bill was successfully created.' }
        format.json { render :show, status: :created, location: @logi_bill }
      else
        format.html { render :new }
        format.json { render json: @logi_bill.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /logi_bills/1
  # PATCH/PUT /logi_bills/1.json
  def update
    respond_to do |format|
      if @logi_bill.update(logi_bill_params)
        format.html { redirect_to @logi_bill, notice: 'Logi bill was successfully updated.' }
        format.json { render :show, status: :ok, location: @logi_bill }
      else
        format.html { render :edit }
        format.json { render json: @logi_bill.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /logi_bills/1
  # DELETE /logi_bills/1.json
  def destroy
    @logi_bill.destroy
    respond_to do |format|
      format.html { redirect_to logi_bills_url, notice: 'Logi bill was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_logi_bill
      @logi_bill = LogiBill.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def logi_bill_params
      params.require(:logi_bill).permit(:name, :endNumber)
    end
end
