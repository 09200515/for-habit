class ObjectivesController < ApplicationController

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
    binding.pry
    if @objective.save
      redirect_to root_path
    else
      render '/objectives/step1'
    end
  end

  private

  def objective_params
    params.require(:objective).permit(:big_area, :text, :small_step1, :small_step2, :small_step3, :small_step4, :small_step5, :if_then1, :if_then2, :if_then3).merge(user_id: current_user.id)
  end


end
