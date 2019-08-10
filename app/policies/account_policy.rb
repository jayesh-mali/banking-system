class AccountPolicy < ApplicationPolicy

  def show?
    (record.user_id == user.id)
  end

  def list_transactions?
    show?
  end

  def status?
    show?
  end

end
