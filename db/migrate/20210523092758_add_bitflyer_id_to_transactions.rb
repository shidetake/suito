class AddBitflyerIdToTransactions < ActiveRecord::Migration[5.2]
  def change
    add_column :transactions, :bitflyer_id, :bigint, after: :mf_id
  end
end
