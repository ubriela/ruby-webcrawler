require 'rubygems'
require 'restclient'
require 'nokogiri'

# This is the URL for the POST request:
CGI_URL = 'http://query.nictusa.com/cgi-bin/fecgifpdf/'

# base_url + f_id = the URL for the form page with the button
base_url = 'http://query.nictusa.com/cgi-bin/fecimg/?'
f_id = 'F26038993028'

## 1 & 2: Retrieve the page with PDF generate button
form_page = Nokogiri::HTML(RestClient.get(base_url + f_id))
button = form_page.css('input[type="hidden"]')[0]

## 3: Do POST request
pdf_resp = RestClient.post(CGI_URL, {button['name']=>button['value'],
   'PDF'=>'Generate+PDF'})

## 4 & 5: A successful POST request will result in a new HTML page to parse
if embed = Nokogiri::HTML(pdf_resp).css('embed')[0]
  pdf_name = embed['src']
  puts "PDF found: #{pdf_name}"
  
## 6: Save PDF to disk
  File.open("#{f_id}--#{pdf_name.match(/\d+\.pdf/)}", 'w') do |f|
    f.write(RestClient.get(pdf_name))
  end
  
end