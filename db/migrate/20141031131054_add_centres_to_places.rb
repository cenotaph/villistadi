class AddCentresToPlaces < ActiveRecord::Migration
  def change
    add_column :places, :centre_lat, :decimal, :precision => 10, :scale => 8
    add_column :places, :centre_lng, :decimal, :precision => 10, :scale => 8
    Place.all.each do |p|
      p.set_centre
      p.save!
    end
  end
end
