#individual opportunity page

class OpptiesController < ApplicationController
  before_action :set_oppty, only: [:show, :edit, :update, :destroy]

  # GET /oppties
  # GET /oppties.json
  def index
    @oppties = Oppty.all
  end

  # GET /oppties/1
  # GET /oppties/1.json
  def show
    @numWriters=UserOppty.where(oppty_id: params[:id]).joins(:user).where('users.role'=>'writer').count
    puts @numWriters
  end

  # GET /oppties/new
  def new
    @oppty = Oppty.new
  end

  # GET /oppties/1/edit
  def edit
  end

  # POST /oppties
  # POST /oppties.json
  def create
    @oppty = Oppty.new(oppty_params)

    respond_to do |format|
      if @oppty.save
        format.html { redirect_to @oppty, notice: 'Oppty was successfully created.' }
        format.json { render :show, status: :created, location: @oppty }
      else
        format.html { render :new }
        format.json { render json: @oppty.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /oppties/1
  # PATCH/PUT /oppties/1.json
  def update
    respond_to do |format|
      puts oppty_params
      JSON.parse(oppty_params.to_json).each do |item|
        puts item
      end
      if @oppty.update(oppty_params)
        format.html { redirect_to @oppty, notice: 'Oppty was successfully updated.' }
        format.json { render :show, status: :ok, location: @oppty }
      else
        format.html { render :edit }
        format.json { render json: @oppty.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /oppties/1
  # DELETE /oppties/1.json
  def destroy
    @oppty.destroy
    respond_to do |format|
      format.html { redirect_to oppties_url, notice: 'Oppty was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_oppty
      @oppty = Oppty.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def oppty_params
      params.require(:oppty).permit(:opptyId, :opptyName, :idiqCA, :status2, :value, :pWin, :captureMgr, :programMgr, :proposalMgr, :sslOrg, :technicalLead, :sslArch, :ed, :on, :ate, :slComments, :rfpDate, :awardDate, :submitDate, :numWriters,
        :slDir, :leadEstim, :engaged, :solution, :estimate)
    end
end
