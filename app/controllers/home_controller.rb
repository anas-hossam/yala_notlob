class HomeController < ApplicationController
  before_action :authenticate_user!
  respond_to :html, :json

  def index
    @notifications=Notification.all
  end
end
