class Comment < ApplicationRecord
  with_options presence: true do
    validates :body
    validates :user_id
    validates :book_id
  end

  belongs_to :user
  belongs_to :book
  
end
