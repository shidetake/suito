class TransactionsController < ApplicationController
  def update
    user = User.find(params[:id])
    transaction = Transaction.find(params[:transaction][:id])

    if transaction.update_attributes(transaction_params)
      flash[:success] = "Transaction updated"
      redirect_to user
    else
      #flash[:danger] = "Transaction updated"
      redirect_to user
    end
  end

  private

    def transaction_params
      params.require(:transaction).permit(:created_at,
                                          :category_id,
                                          :store_id,
                                          :content,
                                          :yen,
                                          :source_id,
                                          :group_id,
                                          :memo)
    end
end
