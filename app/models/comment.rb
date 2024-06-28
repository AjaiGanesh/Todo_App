class Comment < ApplicationRecord
    belongs_to :task
    validates :description, presence: true

    def create_comment
        raise "Task not found:status:404" unless Task.find_by(id: self.task_id).present?
        save!
    end
end
