module Api
  class GefController < ApplicationController
    def index
      gef_pas = GefProtectedArea.all
      render json: gef_pas, status: 200
    end
  end
end
