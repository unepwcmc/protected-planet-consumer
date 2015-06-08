class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  rescue_from ActionController::RoutingError, with: :render_404

  def raise_404 message='Not Found'
    raise ActionController::RoutingError.new message
  end

  def render_404 exception
    render text: exception.message, status: 404
  end
end
