class AddColumnSpecialityIdToUser < ActiveRecord::Migration
  def change
    add_column :users, :speciality_id, :integer
    add_index :users, :speciality_id

  end
end
