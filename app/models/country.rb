class Country < ApplicationRecord

  before_validation :upcase_all_codes

  validates :name, :alpha_code_2, :alpha_code_3, :currency_code, presence: true
  validates :alpha_code_2, length: { is: 2 }
  validates :alpha_code_3, length: { is: 3 }
  validates :currency_code, length: { is: 3 }

  default_scope { where(deleted_at: nil) }

  scope :search, ->(query) {
    where(alpha_code_2: query.upcase)
      .or(where(alpha_code_3: query.upcase))
      .or(where(currency_code: query.upcase))
  }

  def soft_delete
    update(deleted_at: Time.now)
  end

  def deleted?
    deleted_at.present?
  end

  private

  def upcase_all_codes
    alpha_code_2.upcase!
    alpha_code_3.upcase!
    currency_code.upcase!
  end
end
