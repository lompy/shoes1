class CreateJoinTablePartypeMatter < ActiveRecord::Migration
  def change
    create_join_table :partypes, :matters do |t|
      t.index [:partype_id, :matter_id]
    end
  end
end
