# Configuration de Resque
require 'resque'

Resque.redis = "redis://localhost:#{ENV.fetch('REDIS_PORT')}"