class ApplicationController < ActionController::Base
  def index; end

  def up
    raise "There was an error."
  end

  def redirect_to_home
    redirect_to root_path
  end
end
