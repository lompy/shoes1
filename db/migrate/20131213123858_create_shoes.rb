class CreateShoes < ActiveRecord::Migration
  def change
    create_table :shoes do |t|
      t.string     :name
      t.float      :size
      t.references :color, index: true

      t.timestamps
    end
  end
end
