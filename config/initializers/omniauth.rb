Rails.application.config.middleware.use OmniAuth::Builder do
  provider :stripe_connect, ENV['CLIENT_ID'], ENV['SECRET_KEY'], :scope => 'read_write'
end
