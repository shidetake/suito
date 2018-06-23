class CreateTransactions < ActiveRecord::Migration[5.1]
  def change
    create_table :transactions do |t|
      t.integer :zaim_id
      t.integer :group_id
      t.boolean :valid_record
      t.text :content
      t.integer :yen
      t.float :rate
      t.integer :source_id
      t.integer :store_id
      t.integer :person_id
      t.text :memo
      t.references :user, foreign_key: true
      t.references :category, foreign_key: true

      t.timestamps
    end
  end
end