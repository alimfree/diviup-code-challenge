require 'rubygems' 
require 'factory_girl_rails'

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


# Create sample data 

4.times { FactoryGirl.create :user }
20.times { FactoryGirl.create :list }