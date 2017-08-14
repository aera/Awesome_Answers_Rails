class Like < ApplicationRecord
  belongs_to :user
  belongs_to :question

  validates :question_id, uniqueness: {
    scope: :user_id,
    message: ->(object, data) do
      "You've already liked this #{data[:attribute].downcase}"
    end
  }
end
