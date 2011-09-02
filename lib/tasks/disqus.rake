require "net/http"

DISQUS = YAML.load_file("#{Rails.root.to_s}/config/disqus.yml")[Rails.env]


def get_service(url)
  begin
    res = JSON.parse(Net::HTTP.get_response(URI.parse(url)).body)
    return res
  rescue => e
    puts "Error..."
    posts = []
  end  
end

def get_threads(cursor=nil)
  if cursor==nil
    url = "http://disqus.com/api/3.0/forums/listThreads.json?api_secret=#{DISQUS['api_secret']}&forum=#{DISQUS['forum']}&limit=100"
  else
    url = "http://disqus.com/api/3.0/forums/listThreads.json?api_secret=#{DISQUS['api_secret']}&forum=#{DISQUS['forum']}&limit=100&cursor=#{cursor}"
  end
  
  res = get_service(url)

  if not res["cursor"]["hasNext"]
    res["response"]
  else  
    [ res["response"], get_threads(res["cursor"]["next"]) ].flatten
  end
end

def get_jabolko_id(url)
  begin
    page = Net::HTTP.get_response(URI.parse(url)).body
    page.scan(/(<meta[^>]*>)/).flatten.last.split(" ")[1].split("=").last.scan(/\d+/).first.to_i
  rescue => e
    return nil
  end
end

def set_jabolko_id(thread,identifier)
  jid = "jid-#{identifier}"
  url = "http://disqus.com/api/3.0/threads/update.json?api_secret=#{DISQUS['api_secret']}&forum=#{DISQUS['forum']}&thread=#{thread}&identifier=#{jid}"
  HTTParty.post(url)
end

namespace :disqus do 

desc "Open Debugger with S3 loaded"
task :fetch_ids do
  test = "start"

  @threads = nil
  if not File.exist? 'threads.txt'
    @threads = get_threads
    File.open('threads.txt', 'w') do |f|
      Marshal.dump(@threads, f)  
    end
  else
    File.open('threads.txt') do |f|  
      @threads = Marshal.load(f)  
    end  
  end

  ch_list = []
  @threads[1..30].each do |t|
    jid = get_jabolko_id(t["link"])
    th = t["id"]
    resp = set_jabolko_id(th,jid)
    puts "Updated #{th} : #{jid} : #{t['link']}"
  end

  # debugger
  test = "end"
end
  
end