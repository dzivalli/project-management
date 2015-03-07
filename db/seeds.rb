# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Create default(own) company and save it into general settings
# company = Company.find_or_create_by(name: 'Default', email: 'email@example.com',
#                          website: 'http://example.com', address: 'ул. Красная 1',
#                          phone: '000-00-00', city: 'Краснодар')
#
# s = Setting.find_or_create_by(key: 'company')
# s.update(value: company.id)

Role.create!([{name: 'staff'}, {name: 'customer'}, {name: 'admin'}, {name: 'root'}])

# User.create!(username: 'admin', full_name: 'admin', email: 'admin@example.com',
#             password: 'admin', password_confirmation: 'admin',
#             role: Role.find_by_name('root'))

PaymentMethod.create!([{name: 'Онлайн'}, {name: 'Наличные'}, {name: 'Перевод'}])

EmailTemplate.create!(
    [{name: 'Платеж получен', group: 'Счета', body: '<div>Уважаемый клиент,</div><div><br></div><div>Мы получили Ваш платеж
      по счету: {{INVOICE}}</div><div><br></div><div>С уважением,</div>'},
     {name: 'Выставление счета', group: 'Счета', body: '<div>Уважаемый клиент,&nbsp;</div><div><br></div><div>Вам выставлен счет
      на сумму: {{AMOUNT_DUE}}</div><div>Вы можете его оплатить по ссылке: {{URL_TO_PAY}}</div><div><br></div><div>С
      уважением,<br>{{SIGN}}</div>'},
     {name: 'Повторная отправка', group: 'Счета', body: 'Уважаемый клиент,<br><br>Напоминаем Вам, что у вас есть задолженность по
      счету: {{INVOICE}}<br><div>Вы можете его оплатить по ссылке: {{URL_TO_PAY}}</div><div><br></div><div>С
      уважением,<br>{{SIGN}}</div>'},
     {name: 'Регистрация', group: 'Аккаунт', body: ''},
     {name: 'Восстановление пароля', group: 'Аккаунт', body: ''},
     {name: 'Сброс пароля', group: 'Аккаунт', body: ''},
     {name: 'Смена почты', group: 'Аккаунт', body: ''},
     {name: 'Добавление файла', group: 'Проекты', body: ''},
     {name: 'Назначение проекта', group: 'Проекты', body: ''},
     {name: 'Завершение проекта', group: 'Проекты', body: ''},
     {name: 'Назначение задачи', group: 'Проекты', body: ''},
     {name: 'Завершение задачи', group: 'Проекты', body: ''},
     {name: 'Оповищение комманде', group: 'Заявки', body: ''},
     {name: 'Оповищение клиенту', group: 'Заявки', body: ''},
     {name: 'Ответ', group: 'Заявки', body: ''},
     {name: 'Закрытие', group: 'Заявки', body: ''}])
