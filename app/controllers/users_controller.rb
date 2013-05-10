
class UsersController < ApplicationController
  before_filter :authenticate_user!, :except => [:new]

  layout :none_for_xhr
  def none_for_xhr
    'application' unless request.xhr?
  end

  def search
    if params['search_query'].nil? or params['search_query'].empty?
      @users = [] 
    else
      @users = User.search(params['search_query'])
    end

    if @users.length == 1
      redirect_to action: 'show', id: @users[0].id
    else
      respond_to do |format|
        format.html
        format.json { render json: @users}
      end
    end
  end

  def follow
    @user = User.find(params[:id])

    respond_to do |format|
      if current_user
        if current_user == @user
          format.html { redirect_to request.referer, alert: "You can't follow your own self!" }
        else
          current_user.follow(@user)
          format.html { redirect_to request.referer, notice: 'You are now following %s'% @user.name }
        end
      else
        format.html { redirect_to request.referer, alert: "You must be signed in!" }
      end
    end
  end

  def unfollow
    @user = User.find(params[:id])

    respond_to do |format|
      if current_user
        current_user.stop_following(@user)

        format.html { redirect_to request.referer, notice: 'You have unfollowed %s'% @user.name }
      else
        format.html { redirect_to request.referer, alert: "You must be signed in!" }
      end
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])
    @pledges = Pledge.where('user_id = ?', @user.id).recent_pledges

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user.to_json(:include => @pledges)}
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/1/edit
  def edit
    if params[:id] == current_user.id
      @user = User.find(params[:id])
    else
      @user = current_user
    end
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
      @user = User.find(params[:id])

      respond_to do |format|
        if @user.update_attributes(params[:user])
          format.html { redirect_to @user, notice: 'User was successfully updated.' }
          format.json { head :no_content }
        else
          format.html { render action: "edit" }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    if params[:id] == current_user.id
      @user = User.find(params[:id])
      @user.destroy

      respond_to do |format|
        format.html { redirect_to users_url }
        format.json { head :no_content }
      end
    end
  end
end