class PhotosController < ApplicationController
  before_action :set_photo, only: [:show, :edit, :update, :destroy]

  # GET /photos
  # GET /photos.json
  def index
    @photos = Photo.all
  end

  # GET /photos/1
  # GET /photos/1.json
  def show

  end

  def uploads
    @user = params[:uid]
    @photos = Photo.where(:uid=>@user)
    respond_to do |wants|

      wants.html { render :layout => false }
    end
  end

  # GET /photos/new
  def new
    @photo = Photo.new
    @photo.uid = session[:user]
  end

  # GET /photos/1/edit
  def edit
  end

  # POST /photos
  # POST /photos.json
  def create
    @photo = Photo.new(photo_params)

    #------
    #PART 3: for uploading photos

    # get the file_type that have been uploaded
    file_type = params[:photo][:picture].content_type

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
        f.write params[:photo][:picture].read
      end


     @photo.name = file_name

    else
      puts "Error! Should be in jpeg/png"
    end
    #------

    respond_to do |format|
      if @photo.save
        format.html { redirect_to @photo, notice: 'Photo was successfully created.' }
        format.json { render action: 'show', status: :created, location: @photo }
      else
        format.html { render action: 'new' }
        format.json { render json: @photo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /photos/1
  # PATCH/PUT /photos/1.json
  def update
    respond_to do |format|
      if @photo.update(photo_params)
        format.html { redirect_to @photo, notice: 'Photo was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @photo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /photos/1
  # DELETE /photos/1.json
  def destroy
    @photo.destroy
    respond_to do |format|
      format.html { redirect_to photos_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_photo
      if params[:id]== ("uploads")
        redirect_to :controller => 'photos',:action => 'uploads'
      end
      @photo = Photo.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def photo_params
      params.require(:photo).permit(:id, :uid, :name, :caption, :tags, :bidder_id, :bid)
    end
end
