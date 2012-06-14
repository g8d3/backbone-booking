class CreateMeetings < ActiveRecord::Migration
  def change
    create_table :meetings do |t|
      t.integer :landlord_id
      t.integer :tenant_id
      t.datetime :at
      t.boolean :cancelled, default: false
      t.timestamps
    end

    add_index :meetings, :landlord_id
    add_index :meetings, :tenant_id
  end
end
