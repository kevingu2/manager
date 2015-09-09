#individual opportunity page

class OpptiesController < ApplicationController
  CRM_PATH = File.join(Rails.root, "public", "uploads")
  before_action :set_oppty, only: [:show, :edit, :update]

  # GET /oppties/1
  # GET /oppties/1.json
  def show
    if params[:id].nil?
      redirect_to invalid_entry_index_path, notice:"Invalid History"
    end
    @numWriters=UserOppty.where(oppty_id: params[:id]).joins(:user).where('users.role'=>'Writer').count
  end


  # GET /oppties/1/edit
  def edit
  end

  # PATCH/PUT /oppties/1
  # PATCH/PUT /oppties/1.json
  def update
    respond_to do |format|
      excelFileName=nil
      if Dir[CRM_PATH+'/*.xlsm'][0]
        excelFileName=File.basename(Dir[CRM_PATH+'/*.xlsm'][0])
      end
      if excelFileName
        arg="["
        JSON.parse(oppty_params.to_json).each do |item|
          arg << '[\'' + @oppty.coordinate + '\', \'' + item[0] + '\', \'' + item[1] + '\'], '

        end
        arg = arg[0..-3]
        arg <<"]"
      end
      puts `python bin/xmlEditor.py "public/uploads/data/xl/sharedStrings.xml" "public/uploads/data/xl/worksheets/sheet2.xml" "#{arg}"`
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
      params.require(:oppty).permit(:slArch, :slComments,:slDir, :leadEstim, :engaged, :solution, :estimate)
    end
end