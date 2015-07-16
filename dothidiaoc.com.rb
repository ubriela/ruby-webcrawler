# encoding: utf-8
#estate2
require ("B:\\Dropbox\\Startup\\Ruby\ programming\\crawler.rb")
require ("B:\\Dropbox\\Startup\\Ruby\ programming\\models.rb")

class DoThiDiaOc < Crawler
  def initialize
    super( 7, 'dothidiaoc.com', 0 )
    @VIP = false
    @LINK_REGION = 'div#mid1 div.bds_cb span.bds_cb_textblue > a'
    #@ESTATE_TYPE = 'div#breadcrumbs a:last-of-type'
    @ESTATE_TITLE = 'div.product_detail_boxr_title'
    #@ESTATE_DESCRIPTION = "div#mid1 div.product_detail_boxr_detail1 span.label_mota[text()^=#{@HTML_DECODE.decode('M&#244; t&#7843;')}]"
    @ESTATE_DESCRIPTION = '//*[@id="mid1"]/div[3]/div[2]/div[2]/div[2]/p/text()'
    @ESTATE_AREA = "div#mid1 div.product_detail_boxr_detail_box div.left_label_detail[text()^=#{@HTML_DECODE.decode('Di&#7879;n t&#237;ch khu&#244;n vi&#234;n:')}]"
    @ESTATE_PRICE_DESCRIPTION = "div#mid1 div.product_detail_boxr_detail_box div.left_label_detail[text()^=#{@HTML_DECODE.decode('Gi&#225; tham kh&#7843;o:')}]"
    @ESTATE_ADDRESS = "div#mid1 div.product_detail_boxr_detail_box div.left_label_detail[text()^=#{@HTML_DECODE.decode('V&#7883; tr&#237;:')}]"
    @ESTATE_PUBLISH_DATE = "div#mid1 div.product_detail_boxr_detail_box div.left_label_detail[text()^=#{@HTML_DECODE.decode('C&#7853;p nh&#7853;t:')}]"

    @ESTATE_CONTACT_NAME = "div#mid1 div.ttnd_box ul li[text()^=#{@HTML_DECODE.decode('T&#234;n ng&#432;&#7901;i &#273;&#259;ng:')}]"
    @ESTATE_CONTACT_MOBILE = "div#mid1 div.ttnd_box ul li[text()^=#{@HTML_DECODE.decode('&#272;i&#7879;n tho&#7841;i:')}]"
    @ESTATE_CONTACT_EMAIL = "div#mid1 div.ttnd_box ul li[text()^=#{@HTML_DECODE.decode('Email:')}]"

    @ESTATE_PROPERTY_TYPE = "div#mid1 div.ttct_line_co2_1[text()=#{@HTML_DECODE.decode('Lo&#7841;i &#273;&#7883;a &#7889;c:')}]"
    @ESTATE_LEGAL = "div#mid1 div.ttct_line_co2_1[text()^=#{@HTML_DECODE.decode('Ph&#225;p l&#253;:')}]"
    @ESTATE_DIRECTION = "div#mid1 div.ttct_line_co2_1[text()^=#{@HTML_DECODE.decode('H&#432;&#7899;ng:')}]"
    @ESTATE_STREET_WIDTH = "div#mid1 div.ttct_line_co2_1[text()^=#{@HTML_DECODE.decode('&#272;&#432;&#7901;ng tr&#432;&#7899;c nh&#224;:')}]"
    @ESTATE_FLOOR_NUMBER = "div#mid1 div.ttct_line_co2_1[text()^=#{@HTML_DECODE.decode('S&#7889; l&#7847;u:')}]"
    @ESTATE_ROOM_NUMBER_DESCRIPTION = "div#mid1 div.ttct_line_co2_1[text()^=#{@HTML_DECODE.decode('S&#7889; ph&#242;ng:')}]"

  end

  def has_new()
    return true
  end

  def traverse()
    list_new = Set.new
    @TRAVERSE_POINT = @TRAVERSE_POINT + 1
    if @TRAVERSE_POINT == 1400
      @STOP = true
    end
    page = open_page( "http://dothidiaoc.com/tim-kiem-nhanh.html?page=#{@TRAVERSE_POINT}" )
    if page != nil
      page = Hpricot( page )
      page.search(@LINK_REGION).each do |url|
        list_new.add("http://dothidiaoc.com#{url.attributes['href']}")
      end
    end
    return list_new
  end

  # Override parse_page in superclass to get the information of one estate
  def parse_page( page_url )
    begin
      page = open_page( page_url )
      page = Hpricot( page )
      new_estate = Estate2.new
      #estate_element = page.at( @ESTATE_TYPE )
      #if estate_element != nil
      #	new_estate.estate_type = estate_element.inner_text.strip
      #end
      #puts "Type: #{new_estate.estate_type}"
      estate_element = page.at( @ESTATE_TITLE )
      if estate_element != nil
      new_estate.title = estate_element.inner_text.strip
      end
      puts "Title: #{new_estate.title}"

      estate_element = page.search( @ESTATE_DESCRIPTION )
      if estate_element != nil
      new_estate.description = estate_element.following_siblings.inner_html().strip
      end
      puts "Description: #{new_estate.description}"

      estate_element = page.at( @ESTATE_AREA )
      if estate_element != nil
        temp = estate_element.following_siblings.inner_text.strip
        list_temp = temp.split(" ")
        if list_temp.length == 2
        new_estate.area = list_temp[0].strip
        new_estate.area_unit = list_temp[1].strip
        else
        new_estate.area = temp
        end
      end
      puts "Area: #{new_estate.area}"
      puts "Area unit: #{new_estate.area_unit}"

      estate_element = page.at( @ESTATE_PRICE_DESCRIPTION )
      if estate_element != nil
        temp = estate_element.following_siblings.inner_text.strip
        list_temp = temp.split(" ")
        if list_temp.size() >= 2
        new_estate.price = list_temp[0].strip
        new_estate.price_unit = list_temp[1].strip
        end
      end
      puts "Price: #{new_estate.price}"
      puts "Price unit: #{new_estate.price_unit}"

      estate_element = page.at( @ESTATE_ADDRESS )
      if estate_element != nil
        new_estate.address = estate_element.following_siblings.inner_text.strip.gsub("               ",'')
      end
      puts "Address: #{new_estate.address}"

      estate_element = page.at( @ESTATE_PUBLISH_DATE )
      if estate_element != nil
        date_description = estate_element.following_siblings.inner_text.strip
        list_date = date_description.split(" ");
        if (list_date.size() >= 1)
          date = Date.strptime(list_date[0].strip.gsub('-','/') , "%d/%m/%Y" )
        new_estate.new_publish_date = date
        end
      end
      puts "Publish date: #{new_estate.new_publish_date}"

      estate_element = page.at( @ESTATE_CONTACT_NAME )
      if estate_element != nil
        list_temp = estate_element.inner_text.split(':');
        if list_temp.size() == 2
        new_estate.contact_name = list_temp[1].strip;
        end
      end
      puts "Contact name: #{new_estate.contact_name}"

      estate_element = page.at( @ESTATE_CONTACT_MOBILE )
      if estate_element != nil
        list_temp = estate_element.inner_text.split(':');
        if list_temp.size() == 2
        new_estate.contact_mobile = list_temp[1].strip;
        end
      end
      puts "Contact mobile: #{new_estate.contact_mobile}"

      estate_element = page.at( @ESTATE_CONTACT_EMAIL )
      if estate_element != nil
        list_temp = estate_element.inner_text.split(':');
        if list_temp.size() == 2
        new_estate.contact_email = list_temp[1].strip;
        end
      end
      puts "Contact email: #{new_estate.contact_email}"

      estate_element = page.at( @ESTATE_PROPERTY_TYPE )
      if estate_element != nil
      new_estate.property_type = estate_element.following_siblings.inner_text.strip
      end
      puts "Property type: #{new_estate.property_type}"

      estate_element = page.at( @ESTATE_LEGAL )
      if estate_element != nil
      new_estate.legal = estate_element.following_siblings.inner_text.strip
      end
      puts "Legal: #{new_estate.legal}"

      estate_element = page.at( @ESTATE_DIRECTION )
      if estate_element != nil
      new_estate.direction = estate_element.following_siblings.inner_text.strip
      end
      puts "Direction: #{new_estate.direction}"

      estate_element = page.at( @ESTATE_FLOOR_NUMBER )
      if estate_element != nil
        if estate_element.following_siblings.inner_text.strip != 0
        new_estate.floor_number = estate_element.following_siblings.inner_text.strip
        end
      end
      puts "Floor number: #{new_estate.floor_number}"

      estate_element = page.at( @ESTATE_STREET_WIDTH )
      if estate_element != nil
      temp = estate_element.following_siblings.inner_text.strip
      end
      puts "Street width: #{new_estate.street_width}"

      new_estate.new_link = page_url
      return new_estate
    rescue
      puts "ERROR => [parse_page] [#{page_url}]: [#{$!}]"
    end
  end

end