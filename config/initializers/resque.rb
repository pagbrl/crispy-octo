# Configuration de Resque
require 'resque'

Resque.redis = "redis://#{ENV.fetch('REDIS_HOST')}:#{ENV.fetch('REDIS_PORT')}"