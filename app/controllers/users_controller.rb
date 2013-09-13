class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
         if params[:id]<=> ("sign_in")
          redirect_to :controller => 'authentication',:action => 'show'
        end
  end


  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)


      #PART 1: for the profile pic

      # get the file_type that have been uploaded
      file_type = params[:user][:profile_pic].content_type

      # check the file type for images
      if file_type == 'image/jpeg' || file_type == 'image/jpg' || file_type == 'image/png' || file_type == 'image/gif' || file_type == 'image/bmp'

        r = Random.new
        num = r.rand(1...100)

        # as per the file type give the images name
        case file_type
          when "image/jpeg"
            file_name = "pic_#{Time.now.strftime("%Y%m%d%H%M%S")+num.to_s}.jpg"
          when "image/png"
            file_name = "pic_#{Time.now.strftime("%Y%m%d%H%M%S")+num.to_s}.png"
          when "image/gif"
            file_name = "pic_#{Time.now.strftime("%Y%m%d%H%M%S")+num.to_s}.gif"
          when "image/bmp"
            file_name = "pic_#{Time.now.strftime("%Y%m%d%H%M%S")+num.to_s}.bmp"
        end

        # give the file path for image
        file_path = File.join(Rails.root, 'public', 'images', 'upload_images', file_name)

        # copy the image from the uploaded one to file_path
        File.open(file_path, 'wb') do |f|
          f.write params[:user][:profile_pic].read
        end


        @user.profile_pic = file_name

      else
       puts "Error! Should be in jpeg/png"
      end
      #PART 2: for the background pic

      # get the file_type that have been uploaded
    file_type2 = params[:user][:background_pic].content_type

    # check the file type for images
    if file_type2 == 'image/jpeg' || file_type == 'image/jpg' || file_type2 == 'image/png' || file_type2 == 'image/gif' || file_type2 == 'image/bmp'

      r = Random.new
      num = r.rand(1...100)

      # as per the file type give the images name
      case file_type2
        when "image/jpeg"
          file_name2 = "pic_#{Time.now.strftime("%Y%m%d%H%M%S")+num.to_s}.jpg"
        when "image/png"
          file_name2 = "pic_#{Time.now.strftime("%Y%m%d%H%M%S")+num.to_s}.png"
        when "image/gif"
          file_name2 = "pic_#{Time.now.strftime("%Y%m%d%H%M%S")+num.to_s}.gif"
        when "image/bmp"
          file_name2 = "pic_#{Time.now.strftime("%Y%m%d%H%M%S")+num.to_s}.bmp"
      end

      # give the file path for image
      file_path2 = File.join(Rails.root, 'public', 'images', 'upload_images', file_name2)

      # copy the image from the uploaded one to file_path
      File.open(file_path2, 'wb') do |f2|
        f2.write params[:user][:background_pic].read
      end


      @user.background_pic = file_name2

    else
      puts "Error! Should be in jpeg/png"
    end


    Rails.logger.debug("debug: Create Called")
    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render action: 'show', status: :created, location: @user }
      else
        format.html { render action: 'new' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end



  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      if !(User.where(id: params[:id]).empty?)
      @user = User.find(params[:id])
      else
      @user = User.find_by_username(params[:username])
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:id, :first_name, :last_name, :username, :password, :address, :city, :state, :country, :profile_pic, :background_pic, :about, :email)
    end
end
