class CreatePartypes < ActiveRecord::Migration
  def change
    create_table :partypes do |t|
      t.string :name

      t.timestamps
    end
  end
end
