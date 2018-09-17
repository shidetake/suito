class CreateTransactions < ActiveRecord::Migration[5.1]
  def change
    create_table :transactions, id: :integer do |t|
      t.integer :zaim_id
      t.boolean :valid_record
      t.text :content
      t.integer :yen
      t.float :rate
      t.text :memo
      t.references :user, type: :integer, foreign_key: true
      t.references :category, type: :integer, foreign_key: true
      t.references :group, type: :integer, foreign_key: true
      t.references :source, type: :integer, foreign_key: true
      t.references :store, type: :integer, foreign_key: true
      t.references :wallet, type: :integer, foreign_key: true

      t.timestamps
    end
  end
end
