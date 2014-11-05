class Gef::WdpaRecord < ActiveRecord::Base
  belongs_to :gef_area, class_name: 'Gef::Area', foreign_key: :gef_area_id

  def generate_data
    consumer = Gef::Consumer.new
    wdpa_api_data = consumer.api_data(wdpa_id: self.wdpa_id)
    gef_data = self.attributes.symbolize_keys.except(:created_at, :updated_at)
    gef_data.merge!(wdpa_api_data).compact
  end
end
