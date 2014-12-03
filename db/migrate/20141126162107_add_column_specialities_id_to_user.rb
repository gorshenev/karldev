class AddColumnSpecialitiesIdToUser < ActiveRecord::Migration
  def change
    add_column :users, :specialities_id, :integer
    add_index :users, :specialities_id
  end
end
