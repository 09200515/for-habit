class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @objective = @user.objectives
    @record = @user.records.order('date ASC')
  end
  
end
