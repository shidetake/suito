class TransactionsController < ApplicationController
  def new
    @transaction = Transaction.new
  end

  def create
    @transaction = current_user.transactions.build(transaction_params)
    if @transaction.save
      flash[:success] = 'Transaction created!'
      redirect_to current_user
    else
      render 'new'
    end
  end

  def update
    transaction = Transaction.find(params[:transaction][:id])

    params[:transaction][:store_id] = get_or_create_store_id(params[:transaction][:store_name])

    flash[:success] = 'Transaction updated' if transaction.update_attributes(transaction_params)
    redirect_to request.referer
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

  def get_or_create_store_id(name)
    if Store.exists?(name: name)
      Store.find_by(name: name).id
    else
      # create store record if it is not exist
      Store.create(name: name).id
    end
  end
end
