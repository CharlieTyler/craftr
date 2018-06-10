if Rails.env.production?
  EasyPost.api_key = ENV["EASYPOST_PRODUCTION_KEY"]
else 
  EasyPost.api_key = ENV["EASYPOST_TEST_KEY"]
end