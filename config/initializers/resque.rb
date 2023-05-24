# Configuration de Resque
require 'resque'

Resque.redis = "redis://redis:#{ENV.fetch('REDIS_PORT')}"