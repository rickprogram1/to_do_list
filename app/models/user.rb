class User < ApplicationRecord
    has_many :tasks, dependent: :destroy
    has_many :likes, dependent: :destroy
    before_save { self.name = name.downcase }
    validates :name, presence: true, length: { maximum: 30 }, uniqueness: { case_sensitive: false }
    has_secure_password
    validates :password, presence: true, length: { minimum: 6 }, allow_nil: true

    # 渡された文字列のハッシュ値を返す
    def User.digest(string)
        cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost 
        BCrypt::Password.create(string, cost: cost)
    end
end
