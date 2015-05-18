class Parcc::Api::ProtectedAreasController < ApplicationController
  def index
    pas_json = Parcc::ProtectedArea.for_api
    render json: pas_json
  end
end
