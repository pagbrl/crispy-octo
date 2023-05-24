uri = URI.parse(ENV.fetch("REDIS_URL"))
REDIS = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)
Resque.redis = REDIS