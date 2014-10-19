class AddFieldsToPlaces < ActiveRecord::Migration
  def change
    add_column :place_translations, :getting_there, :text
    add_column :place_translations, :see_and_experience, :text
    add_column :place_translations, :more_information, :text
    add_column :places, :pdf, :string
    add_column :place_translations, :facts, :text
    add_column :place_translations, :future_of, :text
  end
end
