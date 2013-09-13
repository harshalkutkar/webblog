class AuthenticationController < ApplicationController

 def show
             @user = User.new
 end

  def login
         @user = User.new
          #Check credentials here
          @user.email = params[:user][:email]
          @user.password = params[:user][:password]

        @user = User.find_by_email(@user.email)
    if (@user)
        if @user.valid_password?(params[:user][:password])
          @authenticated_user = @user
        end
    else
      flash.now[:error] = "Incorrect User ID or password"
    end

      if (@authenticated_user)
        @authenticated_user = @authenticated_user.first_name

      else
        flash.now[:error] = "Incorrect User ID or password"
      end
  rescue ActiveRecord::RecordNotFound
        @authenticated_user = "Not found"
  end






end
