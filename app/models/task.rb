class Task < ApplicationRecord
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :iine_users, through: :likes, source: :user
  default_scope -> { order(priority: :desc, created_at: :desc) }
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 30 }

  # タスクをいいねする
  def iine(user)
    likes.create(user_id: user.id)
  end

  # タスクのいいねを解除する
  def uniine(user)
    likes.find_by(user_id: user.id).destroy
  end

  # 現在のユーザーがいいねをしてたらtrueを返す
  def iine?(user)
    iine_users.include?(user)
  end
end
