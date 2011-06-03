# encoding: UTF-8

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

oto = User.new(:password => "geslo123", :email => "otobrglez@gmail.com", :is_admin => 1)
oto.name = "Oto Brglez"
oto.save
david = User.new(:password => "geslo123", :email => "david.praznik@gmail.com", :is_admin => 1)
david.name = "David Praznik"
david.save

categories = Category.create([
  {:title => "Novice", :slug => "novice"},
  {:title => "Mac", :slug => "mac"},
  {:title => "iPhone / iPod", :slug => "iphone-ipod"},
  {:title => "iPad", :slug => "iPad"},
  {:title => "Šnelkurs", :slug => "snelkurs"}
])

articles = Article.create([
  {
      :title => "Prvi članek",
      :category => Category.first,
      :image => "http://www.jabolko.org/blog/308-apple-iwork-za-iphone-in-ipod-touch-uporabnike",
      :intro => "To je uvod",
      :body => "To je vsebina",
      :author => User.first,
      :published => 1
  },
  {
      :title => "Drugi članek",
      :category => Category.last,
      :image => "http://www.jabolko.org/blog/308-apple-iwork-za-iphone-in-ipod-touch-uporabnike",
      :intro => "To je uvod 2",
      :body => "To je vsebina 2",
      :author => User.last,
      :published => 1
  },
])