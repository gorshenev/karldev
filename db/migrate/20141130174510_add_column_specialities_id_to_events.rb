class AddColumnSpecialitiesIdToEvents < ActiveRecord::Migration
  def change
    add_column :events, :specialities_id, :integer
    add_index :events, :specialities_id
  end
end
