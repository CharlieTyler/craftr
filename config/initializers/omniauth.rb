Rails.application.config.middleware.use OmniAuth::Builder do
  provider :stripe_connect, Stripe.client_id, Stripe.api_key, :scope => 'read_write'
end
