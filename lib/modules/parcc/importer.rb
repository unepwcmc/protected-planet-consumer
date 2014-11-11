require 'csv'

class Parcc::Importer
  
  MATCH_COLUMNS = {parcc_id: '', name: 'name', iso_3: 'country', 
                   poly_id: 'polyID', designation: 'designation', 
                   geom_type: 'point', iucn_cat: 'iucn_cat',
                   wdpa_id: 'WDPAID'}

  def import
    files = list_files
    create_pas list_files[0]
  end

  def list_files
    Dir['lib/data/parcc/*']
  end


  def create_pas filename
    protected_areas = read_csv filename
    protected_areas.each do |pa|
      pa_to_create = {}
      MATCH_COLUMNS.each do |final, original|
        pa_to_create[final] = pa[original] if pa[original]
      end
      Parcc::ProtectedArea.create pa_to_create
    end
  end

  def read_csv filename
    CSV.read(filename, headers: true)
  end
end