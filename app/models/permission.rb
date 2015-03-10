class Permission < ActiveRecord::Base
  belongs_to :user
  belongs_to :company
  belongs_to :client

  # SUBJECT_CLASSES = %w(milestone task project)
  # ACTIONS = %w(team)


  ACTIONS = %w(read edit add destroy cost notice)
  OBJ = %w(invoice project payment)

  scope :client_permissions, -> (client) { where(client: client) }

  def self.for_client(project)
    where(company: project.company, subject_id: project.id, subject_class: SUBJECT_CLASSES)
  end


  def self.update_for_client(permissions, project)
    Permission.for_client(project).delete_all
    permissions.each do |p|
      if SUBJECT_CLASSES.include?(p)
        create! company: project.company, subject_id: project.id, action: 'read', subject_class: p
      else
        create! company: project.company, subject_id: project.id, action: p, subject_class: 'project'
      end
    end
  end

  def self.renew(params, user, client)
    client_permissions(client).where(user: user).delete_all
    params.each do |key, _|
      if key.scan(/_/).count == 1
        action, obj = key.split('_')
        obj = obj.singularize
        if ACTIONS.include?(action) && OBJ.include?(obj)
          create! user: user, action: action, subject_class: obj, client: client
        end
      end
    end
  end
end
