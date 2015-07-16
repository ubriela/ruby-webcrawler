require 'open-uri'
require 'nokogiri'

@doc = Nokogiri::XML(File.open("shows.xml"))
characters = @doc.xpath("//dramas//character")
p(characters[1].to_s)

characters = @doc.css("sitcoms name")
p(characters[0].to_s)

first = @doc.css("dramas name").first
p(first)

first2 = @doc.at_css("dramas name")
p(first2)

##########################

@doc = Nokogiri::XML(File.read("parts.xml"))
car_tires = @doc.xpath('//car:tire', 'car' => 'http://alicesautoparts.com/')
p(car_tires)

bike_tires = @doc.xpath('//bike:tire', 'bike' => 'http://bobsbikes.com/')
p(bike_tires)


##########################
@doc = Nokogiri::XML(File.read("atom.xml"))
titles = @doc.css('xmlns|title')
puts(titles)


