# Configuration de Resque
require 'resque'

Resque.redis = ENV.fetch("REDIS_URL")