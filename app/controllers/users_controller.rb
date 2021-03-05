class UsersController < ApplicationController

  def show
    @user = User.find(current_user.id)
    @objective = @user.objectives
    @record = @user.records.order('date ASC')
  end
  
end
