class Desk::HistoriesController < Desk::ApplicationController
  def index
    @histories = Audit.order(id: :desc).page(params[:page])
  end

  def show
    @history = Audit.find(params[:id])
  end
end
