# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'nokogiri'
require 'open-uri'

html_doc = Nokogiri::HTML(open("http://www.languagedaily.com/learn-german/vocabulary/common-german-words-3"))



doc = html_doc.css("tr")[1..-1].each do |card|
 
  Card.create(original: card.css("td")[1].text, translated: card.css("td")[2].text)

end

 