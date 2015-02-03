class Permission < ActiveRecord::Base
  belongs_to :user
  belongs_to :company

  SUBJECT_CLASSES = %w(milestone task project)
  ACTIONS = %w(team)

  def self.for_client(project)
    where(company: project.company, subject_id: project.id, subject_class: SUBJECT_CLASSES)
  end

  def self.update_for_client(permissions, project)
    Permission.for_client(project).delete_all
    permissions.each do |p|
      if SUBJECT_CLASSES.include?(p)
        create! company: project.company, subject_id: project.id, action: 'show', subject_class: p
      else
        create! company: project.company, subject_id: project.id, action: p, subject_class: 'project'
      end
    end
  end
end
