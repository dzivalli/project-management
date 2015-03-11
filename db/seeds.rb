

Role.create!([{name: 'staff'}, {name: 'customer'}, {name: 'admin'}, {name: 'root'}])

PaymentMethod.create!([{name: 'Онлайн'}, {name: 'Наличные'}, {name: 'Перевод'}])

Plan.create!([{name: 'Безлимитный (default for owner)', term: 999}, {name: 'Тестовый период (default for clients)', term: 1}])

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
