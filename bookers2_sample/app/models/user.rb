class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  attachment :profile_image

  has_many :books, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :relationships, class_name: 'Relationship', foreign_key: 'follower_id'
  has_many :followings, through: :relationships, source: :followed
  has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key: 'followed_id'
  has_many :followers, through: :reverse_of_relationships, source: :follower

  validates :name, presence: true, length: { in: 2..20 }, uniqueness: true
  validates :introduction, length: { maximum: 50 }

  def favorited?(book)
    book.favorites.where(user_id: self.id).exists?
  end

  def follow(other_user)
    self.relationships.create(followed_id: other_user.id)
  end

  def unfollow(other_user)
    self.relationships.find_by(followed_id: other_user.id).destroy
  end

  def following?(other_user)
    self.followings.include?(other_user)
  end


  def self.completely_search(word)
    User.where(name: word)
  end

  def self.forward_search(word)
    User.where('name LIKE ?', "#{word}%")
  end

  def self.backward_search(word)
    User.where('name LIKE ?', "%#{word}")
  end
  
  def self.partial_search(word)
    User.where('name LIKE ?', "%#{word}%")
  end
end
