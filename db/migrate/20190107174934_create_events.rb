class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.text :title
      t.text :description
      t.timestamp :date
      t.text :link
      t.text :source_id

      t.timestamps
    end
  end
end
