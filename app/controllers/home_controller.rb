class HomeController < ApplicationController
  before_action :authenticate_user!
  respond_to :html, :json
  
  def index
  end
end
