class CreateWeirdSites < ActiveRecord::Migration
  def change
    create_table :weird_sites do |t|
      t.string :url, :length => 512
      t.string :name, :length => 64

      t.timestamps
    end
  end
end
