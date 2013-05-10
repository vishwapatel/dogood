class PledgesController < ApplicationController

  before_filter :authenticate_user!
  
  layout :none_for_xhr
  def none_for_xhr
    'application' unless request.xhr?
  end

  # GET /pledges
  # GET /pledges.json
  def index
    @pledges = Pledge.where('user_id = ?', current_user.id)

      respond_to do |format|
        format.html # index.html.erb
        format.json { render json: @pledges }
      end
  end

  # GET /pledges/1
  # GET /pledges/1.json
  def show
    @pledge = Pledge.find(params[:id])

    @user = @pledge.user

    if request.xhr?
      render @pledge, :locals => {:user => @pledge.user}
    else
      respond_to do |format|
        if @pledge.user_id == current_user.id
          respond_to do |format|
            format.html # show.html.erb
            format.json { render json: @pledge }
          end
        else
          redirect_to action: 'index', id: current_user.id
        end
      end
    end
  end

  # GET /pledges/recent_pledges
  def recent_pledges
    @pledges = Pledge.where('user_id = ?', current_user.id).recent_pledges

    respond_to do |format|
      format.html
      format.json { render json: @pledges}
    end
  end


  # GET /pledges/new
  # GET /pledges/new.json
  def new
    @pledge = Pledge.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @pledge }
    end
  end

  # GET /pledges/1/edit
  def edit
    @pledge = Pledge.find(params[:id])
  end

  # POST /pledges
  # POST /pledges.json
  def create

    @pledge = Pledge.new
    @pledge.pledge_title = params[:pledge]['pledge_title']
    @pledge.pledge_description = params[:pledge]['pledge_description']
    @pledge.user_id = current_user.id
    @pledge.save()

      respond_to do |format|
        if @pledge.save
          format.html { redirect_to @pledge, notice: 'Pledge was successfully created.' }
          format.json { render json: @pledge, status: :created, location: @pledge }
        else
          format.html { render action: "new" }
          format.json { render json: @pledge.errors, status: :unprocessable_entity }
        end
      end
  end

  # PUT /pledges/1
  # PUT /pledges/1.json
  def update
    @pledge = Pledge.find(params[:id])

    respond_to do |format|
      if @pledge.update_attributes(params[:pledge])
        format.html { redirect_to :action => 'index', notice: 'Pledge was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @pledge.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pledges/1
  # DELETE /pledges/1.json
  def destroy
    @pledge = Pledge.find(params[:id])
    @pledge.destroy

    redirect_to request.referer
  end
end
