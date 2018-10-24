class Like < ApplicationRecord
    belongs_to :user
    belongs_to :task
    counter_culture :task
    validates :user_id, presence: true
    validates :task_id, presence: true
end
