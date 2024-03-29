class ObjectivesController < ApplicationController
  before_action :authenticate_user!, only: [:step1, :step2, :step3, :edit, :destroy]
  before_action :set_objective, only: [:edit, :update, :show, :destroy]
  before_action :redirect, only: [:edit, :update, :destroy]

  def index
    @objective = Objective.order('created_at DESC')
    @record = @objective.records
  end

  def step1
    @objective = Objective.new
  end

  def step2
    session[:big_area] = objective_params[:big_area]
    session[:text] = objective_params[:text]
    @objective = Objective.new
  end

  def step3
    session[:small_step1] = objective_params[:small_step1]
    session[:small_step2] = objective_params[:small_step2]
    session[:small_step3] = objective_params[:small_step3]
    session[:small_step4] = objective_params[:small_step4]
    session[:small_step5] = objective_params[:small_step5]
    @objective = Objective.new
  end

  def create
    @objective = Objective.new(
      big_area: session[:big_area],
      text: session[:text],
      small_step1: session[:small_step1],
      small_step2: session[:small_step2],
      small_step3: session[:small_step3],
      small_step4: session[:small_step4],
      small_step5: session[:small_step5],
      if_then1: objective_params[:if_then1],
      if_then2: objective_params[:if_then2],
      if_then3: objective_params[:if_then3],
      user_id: current_user.id
    )
    if @objective.save
      redirect_to user_path(current_user.id), notice: "目標の設定が完了しました！ さっそく行動に移してみましょう！"
    else
      render '/objectives/step1'
    end
  end

  def edit
  end

  def update
    if @objective.update(objective_params)
      redirect_to objective_path(@objective.id), notice: "目標の編集が完了しました！"
    else
      render :edit
    end
  end

  def show
    @record = @objective.records
  end

  def destroy
    @objective.destroy
    redirect_to user_path(current_user.id), notice: "目標の削除が完了しました"
  end

  private

  def objective_params
    params.require(:objective).permit(:big_area, :text, :small_step1, :small_step2, :small_step3, :small_step4, :small_step5, :if_then1, :if_then2, :if_then3).merge(user_id: current_user.id)
  end

  def set_objective
    @objective = Objective.find(params[:id])
  end

  def redirect
    if current_user.id != @objective.user_id
      redirect_to root_path
    end
  end
end
