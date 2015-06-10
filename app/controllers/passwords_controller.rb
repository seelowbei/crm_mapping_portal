class PasswordsController < ApplicationController
  def edit
  end

  def update
    if params[:password] == params[:password_confirmation]
      current_user.password = params[:password]
      current_user.password_confirmation = params[:password]
      if current_user.save
        sign_in current_user, :bypass => true
        flash[:notice] = "Password successfully changed"
        redirect_to root_path
      else
        flash[:error] = "Password & Password Confirmation should have at least 8 chacracters!"
        render :edit
      end
    else
      flash[:error] = "Password and Password Confirmation do not match!"
      render :edit
    end
  end
end
