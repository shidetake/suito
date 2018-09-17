class CreateWallets < ActiveRecord::Migration[5.1]
  def change
    create_table :wallets, id: :integer do |t|
      t.string :name

      t.timestamps
    end
  end
end
