class TransactionSerializer < ActiveModel::Serializer
  attributes :id, :transaction_id, :amount, :created_at
end
