
require ("B:\\Dropbox\\Startup\\Ruby\ programming\\dothidiaoc.com.rb")

def main()

  bds = DoThiDiaOc.new
  bds.run

end

#main()

def test()
  bds = DoThiDiaOc.new
  a = bds.parse_page("http://dothidiaoc.com/bat-dong-san-ban/chi-tiet/29064-ban-gap-nha-mt-nguyen-phuc-chu-p15-q-tan-binh.html")
  insert_to_db(a)
end

test()