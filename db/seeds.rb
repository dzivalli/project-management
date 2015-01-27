# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Create default(own) company and save it into general settings
company = Company.find_or_create_by(name: 'Default company', email: 'email@example.com',
                         website: 'http://example.com', address: 'ул. Красная 1',
                         phone: '000-00-00', city: 'Краснодар')

s = Setting.find_or_create_by(key: 'company')
s.update(value: company.id)
