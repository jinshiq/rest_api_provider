class Api::V1::PhotosController < ApplicationController

  protect_from_forgery with: :null_session
  
  before_action :destroy_session
  
  
  include ActionController::HttpAuthentication::Token::ControllerMethods
  include ActionController::MimeResponds  

  before_action :authenticate
  
  def index
    @photos = Photo.order('created_at')
  end

  def show
	@photo = Photo.find(params[:id])
	
	respond_to do |format|
	  format.html
	  format.json
	end
  end
  
  def new
    @photo = Photo.new
  end

  def edit
    @photo = Photo.find(params[:id])
  end 
  
  def create
    @photo = Photo.new(photo_params)

    respond_to do |format|
      if @photo.save
        format.html { redirect_to api_v1_photo_path(@photo), notice: 'Photo was successfully uploaded.' }
        format.json { render json: @photo, status: :created, location: api_v1_photo_path(@photo) }
		format.xml { render xml: @photo, status: :created, location: api_v1_photo_path(@photo) }
		format.js { flash.now[:notice] = "Photo was successfully uploaded." }
      else
        format.html { render :new }
        format.json { render json: @photo.errors, status: :unprocessable_entity }
		format.xml { render xml: @photo.errors, status: :unprocessable_entity }
		format.js { flash.now[:notice] = "Photo was NOT uploaded." }
      end
    end
  end
  
  def update
    @photo = Photo.find(params[:id])  
    
	respond_to do |format|
      if @photo.update(photo_params)
        format.html { redirect_to api_v1_photo_path(@photo), notice: 'Photo was successfully updated.' }
        format.json { render json: @photo, status: :ok, location: api_v1_photo_path(@photo) }
		format.xml { render xml: @photo, status: :ok, location: api_v1_photo_path(@photo) }
		format.js { flash.now[:notice] = "Photo was successfully updated." }
      else
        format.html { render :edit }
        format.json { render json: @photo.errors, status: :unprocessable_entity }
		format.xml { render xml: @photo.errors, status: :unprocessable_entity }
		format.js { flash.now[:notice] = "Photo was NOT updated." }
      end
    end  
  
  end  
  
  def destroy
	@photo = Photo.find(params[:id])
	@photo.destroy
	flash[:success] = "The photo was destroyed."
	redirect_to api_v1_photos_path
  end
  
  private

  def photo_params
    params.require(:photo).permit(:image, :title)
  end
  
  def destroy_session
    request.session_options[:skip] = true
  end

  
  protected
	
  # Authenticate the user with token basd authentication
  def authenticate
	authenticate_header || authenticate_params || render_unauthorized
  end
  
  def authenticate_header
	authenticate_with_http_token do |token, options|
	  @current_user = User.find_by(api_key: token)
	end
  end

  def authenticate_params
	@current_user = User.find_by(api_key: params[:token])
  end
  
  def render_unauthorized(realm = "Application")
	self.headers["WWW-Authenticate"] = %(Token realm="#{realm.gsub(/"/, "")}")
	render json: 'Bad credentials! You need add api key to url for authentication. Try this: https://aqueous-ocean-76425.herokuapp.com/api/v1/photos?token=rtyT1ma8PMjVwelLt7j2IQtt', status: :unauthorized
  end
    
  
end