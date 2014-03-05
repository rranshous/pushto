class CreateLinks < ActiveRecord::Migration
  def change
    create_table :links do |t|
      t.text :target_url
      t.string :short_name

      t.timestamps
    end
  end
end
