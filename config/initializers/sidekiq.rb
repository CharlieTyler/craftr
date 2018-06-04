require 'sidekiq'
# Copied from SeedMusic, originally coped from http://manuelvanrijn.nl/blog/2012/11/13/sidekiq-on-heroku-with-redistogo-nano/

# Sidekiq.configure_client do |config|
#   config.redis = { :size => 1 }
# end

# Sidekiq.configure_server do |config|
#   # The config.redis is calculated by the 
#   # concurrency value so you do not need to 
#   # specify this. For this demo I do 
#   # show it to understand the numbers
#   config.redis = { :size => 4 }
# end