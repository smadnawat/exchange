# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
# User.create([{email: 'rahul@mobiloitte.com', password: 'password', password_confirmation: 'password', name: 'Rahul', is_admin: 'false'},
#            {email: 'admin@example.com', password: 'password', password_confirmation: 'password', name: 'Mark', is_admin: 'true'}
#           ])
 AdminUser.create(email: 'a@test.com', password: '11111111', password_confirmation: '11111111')