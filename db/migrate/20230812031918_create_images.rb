class CreateImages < ActiveRecord::Migration[7.0]
  def change
    create_table :images do |t|

      t.timestamps
    end

    add_column :images, :image_file, :json
  end
end
