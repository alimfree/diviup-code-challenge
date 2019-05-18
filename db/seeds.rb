require 'rubygems'
require 'factory_bot'
require 'byebug'

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


# Create sample data


fake_user = User.create({ email: 'fake@gmail.com', password: 'password', password_confirmation: 'password' })
byebug

3.times do
  list = FactoryBot.create :list, user_id: fake_user.id
  10.times do
	FactoryBot.create :task, user_id: fake_user.id, list_id: list.id
  end
end


10.times do
  user = FactoryBot.create :user

  3.times do
    list = FactoryBot.create :list, user_id: user.id

    10.times do
      FactoryBot.create :task, user_id: user.id, list_id: list.id
    end
  end
end
