class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  protect_from_forgery with: :null_session
  
  # GET /users
  # GET /users.json
  def index
    @users = User.all
	@user = User.new
	respond_to do |format|
      format.html
	  format.json { render json: @users }
	  format.xml { render xml: @users } 
	  #format.js	  
    end	  
  end

  # GET /users/1
  # GET /users/1.json
  def show
  	respond_to do |format|
      format.html
	  format.json { render json: @user }
	  format.xml { render xml: @user } 
	  #format.js	  
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

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render json: @user, status: :created, location: @user }
		format.xml { render xml: @user, status: :created, location: @user }
		format.js { flash.now[:notice] = "User was successfully created." }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
		format.xml { render xml: @user.errors, status: :unprocessable_entity }
		format.js { flash.now[:notice] = "User was NOT created." }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
		format.xml { head :no_content, status: :ok }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
		format.xml { render xml: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    respond_to do |format|
	  if @user.destroy
        format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
        format.json { head :no_content, status: :ok }
		format.xml { head :no_content, status: :ok }
	  else
        format.html { render :show }
        format.json { render json: @user.errors, status: :unprocessable_entity }
		format.xml { render xml: @user.errors, status: :unprocessable_entity }
      end		
    end
  end

  def about
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :email)
    end
end
