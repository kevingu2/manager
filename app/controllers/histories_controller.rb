#handles one of the databases
#when the task is passed the due date, it'll move to the history database so
#users can view their previous tasks

class HistoriesController < ApplicationController
  before_action :set_history, only: [:show]
  before_action :set_user, only: [:create, :index]

  # GET /histories
  # GET /histories.json
  def index
    puts '*'*30
    puts params[:search]
    puts '*'*30
    order_by = nil
    if params[:sort] != nil
      order_by = "\""+params[:sort]+"\""
    end
    if session[:role]=="Writer"
      if params[:invalid] == "rfpDate"
        @histories = UserHistory.where("user_id = ?", @user.id).includes(:history).where("(\"opptyName\" like ? or \"opptyId\" like ? or \"codeName\" like ? or \"cgOrg\" like ?) and \"rfpDate\" < ? and (\"status2\" == ? or \"status2\" == ? or \"status2\" == ?)", "%#{params[:search]}%", "%#{params[:search]}%", "%#{params[:search]}%", "%#{params[:search]}%", Date.today().to_s, "P1-ID/Track", "P2-Qualification", "P3-Pursuit").order(order_by).page(params[:page]).per_page(15)
      elsif params[:invalid] == "leadEstim"
        @histories = UserHistory.where("user_id = ?", @user.id).includes(:history).where("(\"opptyName\" like ? or \"opptyId\" like ? or \"codeName\" like ? or \"cgOrg\" like ?) and (\"leadEstim\" == ? or \"leadEstim\" == ?)", "%#{params[:search]}%", "%#{params[:search]}%", "%#{params[:search]}%", "%#{params[:search]}%", "TBD", "").order(order_by).page(params[:page]).per_page(15)
      elsif params[:invalid] == "technicalLead"
        @histories = UserHistory.where("user_id = ?", @user.id).includes(:history).where("(\"opptyName\" like ? or \"opptyId\" like ? or \"codeName\" like ? or \"cgOrg\" like ?) and (\"technicalLead\" == ? or \"technicalLead\" == ?)", "%#{params[:search]}%", "%#{params[:search]}%", "%#{params[:search]}%", "%#{params[:search]}%", "TBD", "").includes(:history).order(order_by).page(params[:page]).per_page(15)
      elsif params[:invalid] == "slDir"
        @histories = UserHistory.where("user_id = ?", @user.id).includes(:history).where("(\"opptyName\" like ? or \"opptyId\" like ? or \"codeName\" like ? or \"cgOrg\" like ?) and (\"slDir\" == ? or \"slDir\" == ?)", "%#{params[:search]}%", "%#{params[:search]}%", "%#{params[:search]}%", "%#{params[:search]}%", "TBD", "").includes(:history).order(order_by).page(params[:page]).per_page(15)
      elsif params[:invalid] == "slArch"
        @histories = UserHistory.where("user_id = ?", @user.id).includes(:history).where("(\"opptyName\" like ? or \"opptyId\" like ? or \"codeName\" like ? or \"cgOrg\" like ?) and (\"slArch\" == ? or \"slArch\" == ?)", "%#{params[:search]}%", "%#{params[:search]}%", "%#{params[:search]}%", "%#{params[:search]}%", "TBD", "").includes(:history).order(order_by).page(params[:page]).per_page(15)
      elsif params[:invalid] == "sllOrg"
        @histories = UserHistory.where("user_id = ?", @user.id).includes(:history).where("(\"opptyName\" like ? or \"opptyId\" like ? or \"codeName\" like ? or \"cgOrg\" like ?) and
                               ((\"sllOrg\" = ? and (tss_va = ? or tss_va = ?)) or
                                (\"sllOrg\" = ? and (swi_va = ? or swi_va = ?)) or
                                (\"sllOrg\" = ? and (itms_va = ? or itms_va = ?)) or
                                (\"sllOrg\" = ? and (mss_va = ? or mss_va = ?)) or
                                (\"sllOrg\" = ? and (hwi_va = ? or hwi_va = ?)) or
                                (\"sllOrg\" = ? and (ccds_va = ? or ccds_va = ?)) or
                                (\"sllOrg\" = ? and (lsc_va = ? or lsc_va = ?)) or
                                (\"sllOrg\" = ? and (nwi_va = ? or nwi_va = ?)) or
                                (\"sllOrg\" = ? and (sss_va = ? or sss_va = ?)) )",
                                "%#{params[:search]}%", "%#{params[:search]}%", "%#{params[:search]}%", "%#{params[:search]}%",
                                "TSS", 0.0, "",
                                "SWI", 0.0, "",
                                "ITMS", 0.0, "",
                                "MSS", 0.0, "",
                                "HWI", 0.0, "",
                                "CCDS", 0.0, "",
                                "LSC", 0.0, "",
                                "NWI", 0.0, "",
                                "SSS", 0.0, "").includes(:history).order(order_by).page(params[:page]).per_page(15)
      else
          @histories = UserHistory.where("user_id = ?", @user.id).includes(:history).
              where("\"opptyName\" like ? or \"opptyId\" like ? or \"codeName\" like ? or \"cgOrg\" like ?", "%#{params[:search]}%", "%#{params[:search]}%", "%#{params[:search]}%", "%#{params[:search]}%").references(:history).
              order(order_by).page(params[:page]).per_page(15)
      end

    else
      if params[:invalid] == "rfpDate"
        @histories = History.where("(\"opptyName\" like ? or \"opptyId\" like ? or \"codeName\" like ? or \"cgOrg\" like ?) and rfpDate < ? and (status2 == ? or status2 == ? or status2 == ?)", "%#{params[:search]}%", "%#{params[:search]}%", "%#{params[:search]}%", "%#{params[:search]}%", Date.today().to_s, "P1-ID/Track", "P2-Qualification", "P3-Pursuit").order(order_by).page(params[:page]).per_page(15)
      elsif params[:invalid] == "leadEstim"
        @histories = History.where("(\"opptyName\" like ? or \"opptyId\" like ? or \"codeName\" like ? or \"cgOrg\" like ?) and (\"leadEstim\" == ? or \"leadEstim\" == ?)", "%#{params[:search]}%", "%#{params[:search]}%", "%#{params[:search]}%", "%#{params[:search]}%", "TBD", "").order(order_by).page(params[:page]).per_page(15)
      elsif params[:invalid] == "technicalLead"
        @histories = History.where("(\"opptyName\" like ? or \"opptyId\" like ? or \"codeName\" like ? or \"cgOrg\" like ?) and (\"technicalLead\" == ? or \"technicalLead\" == ?)", "%#{params[:search]}%", "%#{params[:search]}%", "%#{params[:search]}%", "%#{params[:search]}%", "TBD", "").order(order_by).page(params[:page]).per_page(15)
      elsif params[:invalid] == "slDir"
        @histories = History.where("(\"opptyName\" like ? or \"opptyId\" like ? or \"codeName\" like ? or \"cgOrg\" like ?) and (\"slDir\" == ? or \"slDir\" == ?)", "%#{params[:search]}%", "%#{params[:search]}%", "%#{params[:search]}%", "%#{params[:search]}%", "TBD", "").order(order_by).page(params[:page]).per_page(15)
      elsif params[:invalid] == "slArch"
        @histories = History.where("(\"opptyName\" like ? or \"opptyId\" like ? or \"codeName\" like ? or \"cgOrg\" like ?) and (\"slArch\" == ? or \"slArch\" == ?)", "%#{params[:search]}%", "%#{params[:search]}%", "%#{params[:search]}%", "%#{params[:search]}%", "TBD", "").order(order_by).page(params[:page]).per_page(15)
      elsif params[:invalid] == "sllOrg"
        @histories = History.where("(\"opptyName\" like ? or \"opptyId\" like ? or \"codeName\" like ? or \"cgOrg\" like ?) and
                               ((\"sllOrg\" = ? and (tss_va = ? or tss_va = ?)) or
                                (\"sllOrg\" = ? and (swi_va = ? or swi_va = ?)) or
                                (\"sllOrg\" = ? and (itms_va = ? or itms_va = ?)) or
                                (\"sllOrg\" = ? and (mss_va = ? or mss_va = ?)) or
                                (\"sllOrg\" = ? and (hwi_va = ? or hwi_va = ?)) or
                                (\"sllOrg\" = ? and (ccds_va = ? or ccds_va = ?)) or
                                (\"sllOrg\" = ? and (lsc_va = ? or lsc_va = ?)) or
                                (\"sllOrg\" = ? and (nwi_va = ? or nwi_va = ?)) or
                                (\"sllOrg\" = ? and (sss_va = ? or sss_va = ?)) )",
                                "%#{params[:search]}%", "%#{params[:search]}%", "%#{params[:search]}%", "%#{params[:search]}%",
                                "TSS", 0.0, "",
                                "SWI", 0.0, "",
                                "ITMS", 0.0, "",
                                "MSS", 0.0, "",
                                "HWI", 0.0, "",
                                "CCDS", 0.0, "",
                                "LSC", 0.0, "",
                                "NWI", 0.0, "",
                                "SSS", 0.0, "").order(order_by).page(params[:page]).per_page(15)
      else 
        @histories = History.where("\"opptyName\" like ? or \"opptyId\" like ? or \"codeName\" like ? or cgOrg like ?", "%#{params[:search]}%", "%#{params[:search]}%", "%#{params[:search]}%", "%#{params[:search]}%").order(order_by).page(params[:page]).per_page(15)
      end
    end
  end

  # GET /histories/1
  # GET /histories/1.json
  def show
    if params[:id].nil?
      redirect_to invalid_entry_index_path, notice:"Invalid History"
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_history
      @history = History.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def history_params
      params.require(:history).permit(:opptyName, :opptyId, :oppty_id, :user_id)
    end

    def set_user
      if session.has_key?(:user_id)
        @user = User.find(session[:user_id])
      end
    end

end