class EmailTemplate < ActiveRecord::Base
  belongs_to :client

  enum group: %w(Счета Проекты Заявки Аккаунт)

  scope :for_client, -> (client) { where(client: client) }
  scope :for_client_by_group, -> (client, group) { where(client: client, group: group) }
  scope :templates, -> { where(client_id: nil) }
end
