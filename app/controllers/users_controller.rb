class UsersController < ApplicationController
  
  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    if current_user.update(update_params) 
      redirect_to :action => "show", :id => current_user.id
    else
      redirect_to :action => "edit", :id => current_user.id
    end
  end
  
  private
    def update_params
      params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
    end
end
