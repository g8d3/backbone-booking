class MeetingsController < ApplicationController
  respond_to :json

  def index
    respond_with Meeting.all
  end

  def show
    respond_with Meeting.find(params[:id])
  end

  def create
    respond_with Meeting.create(params[:meeting])
  end

  def update
    respond_with Meeting.update(params[:id], params[:meeting])
  end

  def destroy
    respond_with Meeting.destroy(params[:id])
  end
end
