class AddSourceType < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :source_type, :string
  end
end
