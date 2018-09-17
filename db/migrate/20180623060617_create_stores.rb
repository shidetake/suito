class CreateStores < ActiveRecord::Migration[5.1]
  def change
    create_table :stores, id: :integer do |t|
      t.string :name

      t.timestamps
    end
  end
end
