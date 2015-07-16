require 'open-uri'
require 'models'
require 'htmlentities'
require 'set'
require 'date'

class Crawler
  def traverse()
    return []
  end

  def has_new()
    return true
  end

  def parse_page( page )
    return nil
  end

  def run()
    if has_new()
      while not @STOP
        list_page = traverse()
        list_page.each() do |page_url|
          new_estate = parse_page( page_url )
          if new_estate != nil
            insert_to_db(new_estate)
          end
          if @STOP
          break
          end
        end
      end
    end
  end

  def initialize( source_id, source_name, traverse_point )
    @SOURCE_ID = source_id
    @SOURCE_NAME = source_name
    @URL_LIST = Array.new
    @STOP = false
    @TRAVERSE_POINT = traverse_point
    @HTML_DECODE = HTMLEntities.new
    @AGENT_LIST = [
			'Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.5; en; rv:1.9.0.8pre) Gecko/2009022800 Camino/2.0b3pre',
			'Mozilla/5.0 (X11; U; Linux i686; en-US) AppleWebKit/534.1 (KHTML, like Gecko) Chrome/6.0.416.0 Safari/534.1',
			'Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US) AppleWebKit/533.9 (KHTML, like Gecko) Chrome/6.0.400.0 Safari/533.9',
			'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US) AppleWebKit/533.8 (KHTML, like Gecko) Chrome/6.0.397.0 Safari/533.8',
			'Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_6_3; en-US) AppleWebKit/533.4 (KHTML, like Gecko) Chrome/5.0.366.0 Safari/533.4',
			'Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.3) Gecko/20100403 Firefox/3.6.3',
			'Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.2.3) Gecko/20100401 Firefox/3.6.3 (.NET CLR 3.5.30729)',
			'Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US; rv:1.9.2.3) Gecko/20100401 Firefox/3.6.3 GTB6 (.NET CLR 3.5.30729)',
			'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.0.15) Gecko/2009101601 Firefox/3.6.3 (.NET CLR 3.5.30729)',
			'Mozilla/5.0 (Macintosh; U; PPC Mac OS X 10.5; en-US; rv:1.9.2.3) Gecko/20100401 Firefox/3.6.3',
			'Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; es-ES; rv:1.9.2.3) Gecko/20100401 Firefox/3.6.3',
			'Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 6.1; WOW64; Trident/4.0; SLCC2; Media Center PC 6.0; InfoPath.2; MS-RTC LM 8)',
			'Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 6.0; Trident/4.0; Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1) )',
			'Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 5.1; Trident/4.0; .NET CLR 1.1.4322; .NET CLR 3.0.04506.30; .NET CLR 3.0.04506.648; .NET CLR 2.0.50727)',
			'Mozilla/5.0 (Windows; U; MSIE 7.0; Windows NT 6.0; en-US)',
			'Mozilla/4.0 (Windows; MSIE 7.0; Windows NT 5.1; SV1; .NET CLR 2.0.50727)',
			'Opera/9.64 (X11; Linux x86_64; U; en) Presto/2.1.1',
			'Opera/9.64 (Windows NT 6.1; U; de) Presto/2.1.1',
			'Opera/9.64 (Windows NT 6.0; U; en)',
			'Opera/9.64 (Windows NT 5.1; U; en) Presto/2.1.1',
			'Mozilla/5.0 (Macintosh; Intel Mac OS X; U; de; rv:1.8.1) Gecko/20061208 Firefox/2.0.0 Opera 9.64',
			'Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_7; en-us) AppleWebKit/533.4 (KHTML, like Gecko) Version/4.1 Safari/533.4',
			'Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US) AppleWebKit/531.22.7 (KHTML, like Gecko) Version/4.0.5 Safari/531.22.7',
			'Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US) AppleWebKit/531.22.7 (KHTML, like Gecko) Version/4.0.5 Safari/531.22.7',
			'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US) AppleWebKit/531.22.7 (KHTML, like Gecko) Version/4.0.5 Safari/531.22.7'
		]
  end

  def open_page( page_url )
    begin
    #sleep( 0.5 )
      page = open( page_url, {'User-Agent' => get_random_agent()} )
      puts "Get [#{page_url}] at [#{Time.now.to_i}] has [#{page.size()} B] "
      return page
    rescue
      puts "ERROR => [open_page] : [#{$!}]"
      return nil
    end
  end

  def get_random_agent()
    return (@AGENT_LIST[rand( @AGENT_LIST.length )])
  end
end