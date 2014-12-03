class DropTableFullcalendarEngineEvents < ActiveRecord::Migration
  def change_table

    drop_table :fullcalendar_engine_events
    drop_table :fullcalendar_engine_event_series

  end
end
