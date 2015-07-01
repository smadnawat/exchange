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
 AdminUser.create(email: 'a@test.com', password: '11111111', password_confirmation: '11111111', username: 'username')
 AdminUser.create(email: 'ab@test.com', password: '11111111', password_confirmation: '11111111', username: 'usernamei')

 User.create(username: 'Testing name1', gender: 'Male', email: 'test1@gmail.com',password: '11111111', password_confirmation: '11111111',location: 'Okhla',date_signup: ' Wed, 10 Jun 2015 13:01:42 +0000',created_at:' Wed, 10 Jun 2015 13:01:42 +0000',updated_at: ' Wed, 10 Jun 2015 13:01:42 +0000',latitude: '4.77',longitude: '5.277', provider: 'FB', u_id: 'sdsdsd',device_used: 'Samsung S4')
 User.create(username: 'Testing name2', gender: 'Male', email: 'test2@gmail.com',password: '22222222', password_confirmation: '22222222',location: 'Govindpuri',date_signup: ' Wed, 10 Jun 2015 13:01:42 +0000',created_at:' Wed, 10 Jun 2015 13:01:42 +0000',updated_at: ' Wed, 10 Jun 2015 13:01:42 +0000',latitude: '4.747',longitude: '35.77', provider: 'FB', u_id: 'sdsdeesd',device_used: 'Samsung S5')
 User.create(username: 'Testing name3', gender: 'Male', email: 'test3@gmail.com',password: '33333333', password_confirmation: '33333333',location: 'Mayur Vihar',date_signup: ' Wed, 10 Jun 2015 13:01:42 +0000',created_at:' Wed, 10 Jun 2015 13:01:42 +0000',updated_at: ' Wed, 10 Jun 2015 13:01:42 +0000',latitude: '4.737',longitude: '55.77', provider: 'FB', u_id: 'sdseedsd',device_used: 'Iphone 6 plus')

 ReadingPreference.create(title: 'Testing title1', author: 'Testing author1', genre: 'Testing genre1',user_id: '1')
 ReadingPreference.create(title: 'Testing title1', author: 'Testing author2', genre: 'Testing genre2',user_id: '1')
 ReadingPreference.create(title: 'Testing title2', author: 'Testing author3', genre: 'Testing genre3',user_id: '2')
 ReadingPreference.create(title: 'Testing title3', author: 'Testing author4', genre: 'Testing genre4',user_id: '1')
 ReadingPreference.create(title: 'Testing title4', author: 'Testing author5', genre: 'Testing genre5',user_id: '2')
 ReadingPreference.create(title: 'Testing title5', author: 'Testing author6', genre: 'Testing genre6',user_id: '1')
 ReadingPreference.create(title: 'Testing title6', author: 'Testing author7', genre: 'Testing genre7',user_id: '2')
 Book.create(title: 'Testing bookA',author: 'AuthorA',genre: 'genreA',upload_date:  'Mon, 22 Jun 2015',upload_date_for_admin: 'Mon, 22 Jun 2015', upload_type: 'Manual', user_id: 1,created_at:' Mon, 22 Jun 2015 13:01:42 +0000',updated_at: ' Mon, 22 Jun 2015 13:01:42 +0000',latitude: '4.77',longitude: '5.277', address: 'New Delhi')
 Book.create(title: 'Testing bookB',author: 'AuthorB',genre: 'genreB',upload_date:  'Mon, 22 Jun 2015',upload_date_for_admin: 'Mon, 22 Jun 2015', upload_type: 'Manual', user_id: 1,created_at:' Mon, 22 Jun 2015 13:01:42 +0000',updated_at: ' Mon, 22 Jun 2015 13:01:42 +0000',latitude: '4.77',longitude: '5.277', address: 'New Delhi')
 Book.create(title: 'Testing bookC',author: 'AuthorC',genre: 'genreC',upload_date:  'Mon, 21 Jun 2015',upload_date_for_admin: 'Mon, 21 Jun 2015', upload_type: 'Manual', user_id: 2,created_at:' Mon, 21 Jun 2015 13:01:42 +0000',updated_at: ' Mon, 21 Jun 2015 13:01:42 +0000',latitude: '4.77',longitude: '5.277', address: 'New Ashok nagar')
 Book.create(title: 'Testing bookD',author: 'AuthorD',genre: 'genreD',upload_date:  'Mon, 21 Jun 2015',upload_date_for_admin: 'Mon, 21 Jun 2015', upload_type: 'Manual', user_id: 2,created_at:' Mon, 21 Jun 2015 13:01:42 +0000',updated_at: ' Mon, 21 Jun 2015 13:01:42 +0000',latitude: '4.77',longitude: '5.277', address: 'New Ashok nagar')
 Book.create(title: 'Testing bookE',author: 'AuthorE',genre: 'genreE',upload_date:  'Mon, 20 Jun 2015',upload_date_for_admin: 'Mon, 20 Jun 2015', upload_type: 'Manual', user_id: 3,created_at:' Mon, 20 Jun 2015 13:01:42 +0000',updated_at: ' Mon, 20 Jun 2015 13:01:42 +0000',latitude: '4.77',longitude: '5.277', address: 'New Okhla')
 Book.create(title: 'Testing bookF',author: 'AuthorF',genre: 'genreF',upload_date:  'Mon, 20 Jun 2015',upload_date_for_admin: 'Mon, 20 Jun 2015', upload_type: 'Manual', user_id: 3,created_at:' Mon, 20 Jun 2015 13:01:42 +0000',updated_at: ' Mon, 20 Jun 2015 13:01:42 +0000',latitude: '4.77',longitude: '5.277', address: 'New Okhla')









