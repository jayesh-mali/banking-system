class TransactionSerializer < ActiveModel::Serializer
  attributes :id, :transaction_id, :amount
end
