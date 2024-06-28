class Project < ApplicationRecord
    belongs_to :user
    has_many :sub_projects, class_name: "Project", foreign_key: "parent_id", dependent: :destroy
    belongs_to :parent, class_name: "Project", optional: true
    has_many :tasks, dependent: :destroy

    validates :description, presence: true, uniqueness: { case_sensitive: false, message: "Already taken"},format: { with: /\A[a-zA-Z]{4,}(?: [a-zA-Z]+){0,2}\z/, message: "Required condition not met" }
    before_destroy :is_project_inbox?

    def is_project_inbox?
        raise "Access Denied" if self.description == "Inbox"
    end

    def create_project(user)
        self.user_id = user.id
        if self.parent_id.present?
            project = Project.find_by(id: self.parent_id.to_i)
            raise "Project not found:status:404" unless project.present?
            raise "Subproject cannot have Project" if project.parent_id != 0
        end
        self.parent_id = parent_id.to_i || 0
        save!
    end

    def move_or_update_project(project_details)
        self.description = project_details[:description] if project_details[:description]
        destination_project_id = project_details[:destination_project_id]
        if destination_project_id.present?
            raise "Project cannot be changed because it is the parent" if self.parent_id.zero?
            raise "Subproject cannot become Project" if destination_project_id.zero?
            self.parent_id = destination_project_id.to_i
        end
        save!
    end
end
