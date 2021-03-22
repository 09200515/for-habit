class RecordsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :time, :time_save, :edit, :destroy]
  before_action :set_record, only: [:edit, :update, :destroy]
  before_action :redirect, only: [:edit, :update, :destroy]

  def index
    @record = Record.order('created_at DESC')
  end

  def new
    @record = Record.new
  end

  def create
    @record = Record.new(record_params)
    if @record.save
      redirect_to objective_path(@record.objective_id)
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

  def edit
  end

  def update
    if @record.update(record_params)
      redirect_to objective_path(@record.objective_id)
      return
    else
      render :edit
    end
  end

  def destroy
    @record.destroy
    redirect_to objective_path(@record.objective_id)
  end

  

  private

  def record_params
    params.require(:record).permit(:date, :data, :unit_id, :inpression).merge(user_id: current_user.id, objective_id: params[:objective_id])
  end

  def set_record
    @record = Record.find(params[:id])
  end

  def redirect
    if current_user.id != @record.user_id
      redirect_to root_path
    end
  end

end
