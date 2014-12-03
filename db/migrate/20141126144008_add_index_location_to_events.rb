class AddIndexLocationToEvents < ActiveRecord::Migration
  def change
    add_index :events, :location
  end
end
