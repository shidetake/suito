class CreateTransactions < ActiveRecord::Migration[5.1]
  def change
    create_table :transactions, id: :integer do |t|
      t.bigint :zaim_id
      t.boolean :valid_record, default: 1
      t.text :content
      t.integer :yen, null: false
      t.float :rate, default: 1.0
      t.text :memo
      t.references :user, type: :integer, foreign_key: true
      t.references :category, type: :integer, foreign_key: true, null: false
      t.references :group, type: :integer, foreign_key: true
      t.references :source, type: :integer, foreign_key: true
      t.references :store, type: :integer, foreign_key: true
      t.references :wallet, type: :integer, foreign_key: true

      t.timestamps
    end
  end
end
