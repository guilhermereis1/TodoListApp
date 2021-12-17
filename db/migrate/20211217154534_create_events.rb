class CreateEvents < ActiveRecord::Migration[6.1]
  def change
    create_table :events, id: :uuid do |t|
      t.json :name
      t.string :event_type
      t.json :properties

      t.timestamps
    end
  end
end
