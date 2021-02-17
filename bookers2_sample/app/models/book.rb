class Book < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  validates :title, :body, presence: true, length: { maximum: 200 }
  
  def self.completely_search(word)
    Book.where(title: word)
  end

  def self.forward_search(word)
    Book.where('title LIKE ?', "#{word}%")
  end

  def self.backward_search(word)
    Book.where('title LIKE ?', "%#{word}")
  end
  
  def self.partial_search(word)
    Book.where('title LIKE ?', "%#{word}%")
  end

end
