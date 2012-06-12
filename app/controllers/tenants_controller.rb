class TenantsController < ApplicationController
  respond_to :json

  def index
    respond_with Tenant.all
  end

  def show
    respond_with Tenant.find(params[:id])
  end

  def create
    respond_with Tenant.create(params[:tenant])
  end

  def update
    respond_with Tenant.update(params[:id], params[:tenant])
  end

  def destroy
    respond_with Tenant.destroy(params[:id])
  end
end
