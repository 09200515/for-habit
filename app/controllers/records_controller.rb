class RecordsController < ApplicationController


  def index
    @record = Record.order('created_at DESC')
  end

  def new
    @record = Record.new
  end

  def create
    @record = Record.new(record_params)
    if @record.save
      redirect_to user_path(current_user.id), notice: "記録が完了しました！"
    else
      render :new
    end
  end

  def time
    @record = Record.new
  end


  private

  def record_params
    params.require(:record).permit(:date, :data, :unit, :inpression).merge(user_id: current_user.id, objective_id: params[:objective_id])
  end


end
