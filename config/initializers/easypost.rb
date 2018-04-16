Rails.configuration.easypost = {
  :production_key => ENV['EASYPOST_PRODUCTION_KEY'],
  :test_key      => ENV['EASYPOST_TEST_KEY']
}

EasyPost.api_key = Rails.configuration.easypost[:test_key]