class Notifications < ApplicationMailer
  default from: 'email-tests@yandex.ru'
  layout false


  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notifications.signup.subject
  #
  def signup(client)
    @client = client

    mail to: client.owner.email, subject: 'Регистрация'
  end
end
