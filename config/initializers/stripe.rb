Rails.configuration.stripe = {
    :publishable_key => Rails.env.production? ? ENV['STRIPE_LIVE_PUBLISHABLE_KEY'] : ENV['STRIPE_TEST_PUBLISHABLE_KEY'],
    :secret_key      => Rails.env.production? ? ENV['STRIPE_LIVE_SECRET_KEY'] : ENV['STRIPE_TEST_SECRET_KEY'],
    :client_id       => Rails.env.production? ? ENV['STRIPE_LIVE_CLIENT_ID'] : ENV['STRIPE_TEST_CLIENT_ID']
}

Stripe.client_id = Rails.configuration.stripe[:client_id]
Stripe.api_key = Rails.configuration.stripe[:secret_key]
STRIPE_PUBLIC_KEY = Rails.configuration.stripe[:publishable_key]