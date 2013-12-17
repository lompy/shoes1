class CreateParts < ActiveRecord::Migration
  def change
    create_table :parts do |t|
      t.references :shoe,    index: true
      t.references :matter,  index: true
      t.references :partype, index: true

      t.timestamps
    end
  end
end
