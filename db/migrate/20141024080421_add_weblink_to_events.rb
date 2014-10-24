class AddWeblinkToEvents < ActiveRecord::Migration
  def change
    add_column :events, :weblink, :string
  end
end
