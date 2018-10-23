class TransactionsController < ApplicationController
  def new
    @transaction = Transaction.new
  end

  def create
    @transaction = current_user.transactions.build(transaction_params)
    if @transaction.save
      flash[:success] = "Transaction created!"
      redirect_to current_user
    else
      render 'new'
    end
  end

  def update
    transaction = Transaction.find(params[:transaction][:id])

    params[:transaction][:store_id] = Store.find_by(name: params[:transaction][:store_name])&.id

    parent_category_id = Category.find_by(name: params[:transaction][:parent_category_name])&.id
    params[:transaction][:category_id] = Category.find_by(name: params[:transaction][:category_name], parent_id: parent_category_id)&.id

    if transaction.update_attributes(transaction_params)
      flash[:success] = "Transaction updated"
      redirect_to current_user
    else
      #flash[:danger] = "Transaction updated"
      redirect_to current_user
    end
  end

  private

    def transaction_params
      params.require(:transaction).permit(:valid_record,
                                          :created_at,
                                          :category_id,
                                          :store_id,
                                          :content,
                                          :yen,
                                          :source_id,
                                          :group_id,
                                          :wallet_id,
                                          :memo)
    end
end
