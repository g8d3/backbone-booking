class CreateMeetings < ActiveRecord::Migration
  def change
    create_table :meetings do |t|
      t.integer :landlord_id
      t.integer :tenant_id
      t.datetime :at

      t.timestamps
    end
  end
end
