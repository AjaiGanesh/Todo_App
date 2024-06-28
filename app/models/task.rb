class Task < ApplicationRecord
    has_many :sub_tasks, class_name: "Task", foreign_key: "parent_id", dependent: :destroy
    belongs_to :parent, class_name: "Task", optional: true
    belongs_to :project
    has_many :comments, dependent: :destroy

    validates :description, presence: true, uniqueness: { case_sensitive: false, message: "Already taken"},format: { with: /\A[a-zA-Z]{4,}(?: [a-zA-Z]+){0,2}\z/, message: "Required condition not met" }

    def create_task
        raise "Please enter the project id" unless self.project_id.present?
        raise "Project not found:status:404" unless self.project.present?
        if self.parent_id.present?
            task = Task.find_by(id: self.parent_id.to_i)
            raise "Task not found:status:404" unless task.present?
            raise "Subtask cannot have task" if task.parent_id != 0
        end
        self.parent_id = parent_id.to_i || 0
        save!
    end

    def move_or_update_task(params)
        self.description = project_details[:description] if params[:description]
        if params[:destination_project_id].present?
            raise "Project not found:status:404" unless self.project.present?
            self.project_id = params[:destination_project_id].to_i
            self.parent_id = 0
        end
        self.label = params[:label].to_s if params[:label].present?
        self.priority_id = params[:priority_id].to_s if params[:priority_id].present?
        self.status_id = params[:status_id] if params[:status_id].present?
        self.start_date_at = params[:start_date_at].to_s if params[:start_date_at].present?
        self.due_date_at = params[:due_date_at] if params[:due_date_at].present?
        save!
    end
end
