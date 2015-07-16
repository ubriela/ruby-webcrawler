require 'rubygems'
require 'active_record'
require 'open-uri'
require 'models'
require 'htmlentities'
require 'hpricot'
require 'set'
require 'date'

ActiveRecord::Base.establish_connection(
:adapter => 'mysql2',
:encoding => 'utf8',
:host => 'localhost',
:database => 'rawdb',
:username => 'root',
:password => 'root'
)
class Estate2Table < ActiveRecord::Base
  set_table_name "estate2"
  set_primary_key "id"
end

def insert_to_db( new_estate )
  if new_estate == nil
    return
  end
  begin
    Estate2Table.create(
    :title => new_estate.title,
    :description => new_estate.description,
    :address => new_estate.address,
    :district => new_estate.district,
    :city => new_estate.city,
    :project => new_estate.project,
    :area => new_estate.area,
    :area_unit => new_estate.area_unit,
    :price => new_estate.price,
    :price_unit => new_estate.price_unit,
    :price_description => new_estate.price_description,
    :contact_name => new_estate.contact_name,
    :contact_address => new_estate.contact_address,
    :contact_phone => new_estate.contact_phone,
    :contact_landline => new_estate.contact_landline,
    :contact_mobile => new_estate.contact_mobile,
    :contact_email => new_estate.contact_email,
    :new_id => new_estate.new_id,
    :new_publish_date => new_estate.new_publish_date,
    :new_expire_date => new_estate.new_expire_date,
    :new_source => @SOURCE_ID,
    :direction => new_estate.direction,
    :number_of_bedroom => new_estate.number_of_bedroom,
    :estate_type => new_estate.estate_type,
    :sale => 1,
    :street_width => new_estate.street_width,
    :front_width => new_estate.front_width,
    :new_link => new_estate.new_link,
    :property_type => new_estate.property_type,
    :legal => new_estate.legal,
    :position => new_estate.position,
    :floor_number => new_estate.floor_number,
    :living_room_number => new_estate.living_room_number,
    :bedroom_number => new_estate.bedroom_number,
    :bathroom_number => new_estate.bathroom_number,
    :other_room_number => new_estate.other_room_number,
    :room_number_description => new_estate.room_number_description
    )
  rescue
    puts $!
  end
end

class Estate2
  attr_accessor :title,:description,:address,:district,:city,:project,:area,:area_unit,:price,:price_unit,:price_description,
    :contact_name,:contact_address,:contact_phone,:contact_mobile,:contact_landline,:contact_email,:new_id, :new_publish_date,:new_expire_date,
    :new_soure, :direction, :number_of_bedroom, :estate_type, :sale, :new_link, :street_width, :front_width, :property_type, :legal,
    :position, :floor_number, :living_room_number, :bedroom_number, :bathroom_number, :other_room_number, :room_number_description
  def to_s
    puts("Title : #{@title}")
    puts("Description : #{@description}")
    puts("Address : #{@address}")
    puts("District : #{@district}")
    puts("City : #{@city}")
    puts("Project : #{@project}")
    puts("Area : #{@area}")
    puts("Area unit : #{@area_unit}")
    puts("Price : #{@price}")
    puts("Price unit : #{@price_unit}")
    puts("Contact name : #{@contact_name}")
    puts("Contact Address : #{@contact_address}")
    puts("Contact Phone : #{@contact_phone}")
    puts("Contact Mobile : #{@contact_mobile}")
    puts("Contact Email : #{@contact_email}")
    puts("New id : #{@new_id}")
    puts("New publish date : #{@new_publish_date}")
    puts("New expire date : #{@new_expire_date}")
    puts("New source : #{@new_source}")
    puts("Direction : #{@direction}")
    puts("Number of bedroom : #{@number_of_bedroom}")
    puts("Street width : #{@street_width}")
    puts("Front width : #{@front_width}")
    puts("Estate type : #{@estate_type}")
    puts("Sale : #{@sale}")
    puts("Link : #{@new_link}")
  end
end
