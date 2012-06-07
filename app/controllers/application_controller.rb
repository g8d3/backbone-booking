class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :redirect_to_root, if: :is_html?

  private
  def redirect_to_root
    redirect_to root_path if params[:controller] != 'main'
  end

  def is_html?
    request.format.to_s =~ /html/
  end
end
