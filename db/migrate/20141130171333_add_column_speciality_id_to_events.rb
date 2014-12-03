class AddColumnSpecialityIdToEvents < ActiveRecord::Migration
  def change

    add_column :events, :speciality_id, :integer
    add_index :events, :speciality_id

  end
end
