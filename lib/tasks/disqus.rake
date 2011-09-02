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
    url = "http://disqus.com/api/3.0/forums/listThreads.json?&api_secret=#{DISQUS['api_secret']}&forum=#{DISQUS['forum']}&limit=100"
  else
    url = "http://disqus.com/api/3.0/forums/listThreads.json?&api_secret=#{DISQUS['api_secret']}&forum=#{DISQUS['forum']}&limit=100&cursor=#{cursor}"
  end
  
  res = get_service(url)

  if not res["cursor"]["hasNext"]
    res["response"]
  else  
    [ res["response"], get_threads(res["cursor"]["next"]) ].flatten
  end

end

namespace :disqus do 

desc "Open Debugger with S3 loaded"
task :fetch_ids do
  
  
  
  test = 1

  threads = get_threads

  debugger

  test = 11
  
end
  
end