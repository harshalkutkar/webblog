class AuthenticationController < ApplicationController
  skip_before_filter :verify_authenticity_token
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
          session[:user] = @user.id
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



 def destroy
      reset_session
 end

 def authenticate


   @user = User.new
   #Check credentials here
   @user.email = params[:user][:email]
   @user.password = params[:user][:password]

   @user = User.find_by_email(@user.email)
   if (@user)
     if @user.valid_password?(params[:user][:password])
       @authenticated_user = 1
     end
   else
    @authenticated_user = 0
   end

   if (@authenticated_user)
     @authenticated_user = 1

   else
     @authenticated_user = 0
   end

   respond_to do |wants|

     wants.html { render :layout => false }
   end


 rescue ActiveRecord::RecordNotFound
   @authenticated_user = 0
 end


end
