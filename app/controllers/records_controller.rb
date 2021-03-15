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
      redirect_to user_path(current_user.id)
    else
      render :new
    end
  end

  def time
    @record = Record.new
    @objective = Objective.find(params[:objective_id])

  end

  def time_save
    @record = Record.new(record_params)
    @record.date = Date.today
    @record.unit_id = "1"
    if @record.valid?
      @record.save
      redirect_to time_objective_records_path(params[:objective_id])
    else
      render :time
    end
  end

  private

  def record_params
    params.require(:record).permit(:date, :data, :unit_id, :inpression).merge(user_id: current_user.id, objective_id: params[:objective_id])
  end


end
