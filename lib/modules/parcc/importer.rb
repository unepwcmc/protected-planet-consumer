require 'csv'

class Parcc::Importer
  
  PA_MATCH_COLUMNS = {parcc_id: '', name: 'name', iso_3: 'country', 
                   poly_id: 'polyID', designation: 'designation', 
                   geom_type: 'point', iucn_cat: 'iucn_cat',
                   wdpa_id: 'WDPAID'}

  def import
    files = list_files
    create_pas file_path: list_files[0]
  end

  def populate_values file_path: file_path
    filename_splitted = File.basename(file_path).split
    csv_values = read_csv file_path: file_path
    
    
    csv_values.each do |pa|
      values_to_populate = {}
      values_to_populate.taxonomic_class = filename_splitted[0]
      values_to_populate.year = filename_splitted[3]
      values_to_populate.stat = pa[""]









  end

  def list_files
    Dir['lib/data/parcc/*']
  end


  def create_pas file_path: file_path
    protected_areas = read_csv file_path: file_path
    protected_areas.each do |pa|
      pa_to_create = {}
      MATCH_COLUMNS.each do |final, original|
        pa_to_create[final] = pa[original] if pa[original]
      end
      Parcc::ProtectedArea.create pa_to_create
    end
  end

  def read_csv file_path: file_path
    CSV.read(file_path, headers: true)
  end
end