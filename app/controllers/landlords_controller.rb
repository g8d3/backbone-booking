class LandlordsController < ApplicationController
  respond_to :json

  def index
    respond_with Landlord.all
  end

  def show
    respond_with Landlord.find(params[:id])
  end

  def create
    respond_with Landlord.create(params[:landlord])
  end

  def update
    respond_with Landlord.update(params[:id], params[:landlord])
  end

  def destroy
    respond_with Landlord.destroy(params[:id])
  end
end
