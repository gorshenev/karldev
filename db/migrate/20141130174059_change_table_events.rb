class ChangeTableEvents < ActiveRecord::Migration
  def change

  change_table :events do |t|

  t.remove  :specialities_id
  end
  end
end
