class CreateMenus < ActiveRecord::Migration
  def self.up
    create_table :menus do |t|
      t.references :city, index: true
      t.string :item_type
      t.integer :item_id
      t.integer :parent_id
      t.integer :sort_order
      t.boolean :published
      t.string :url
      t.timestamps
    end
    create_table :menu_hierarchies do |t|
      t.integer :ancestor_id, :null => false
      t.integer :descendant_id, :null => false
      t.integer :generations, :null => false
    end
    
    add_index :menu_hierarchies, [:ancestor_id, :descendant_id, :generations],
      :unique => true, :name => "menu_anc_desc_udx"
      
    add_index :menu_hierarchies, [:descendant_id],
        :name => "menu_desc_idx"    
        
    
  end
  
  def self.down
    drop_table :menus
    drop_table :menu_hierarchies
  end
end
