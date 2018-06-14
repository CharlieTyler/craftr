Rails.configuration.stripe = {
    :publishable_key => Rails.env.production? ? ENV['STRIPE_LIVE_PUBLISHABLE_KEY'] : ENV['STRIPE_TEST_PUBLISHABLE_KEY'],
    :secret_key      => Rails.env.production? ? ENV['STRIPE_LIVE_SECRET_KEY'] : ENV['STRIPE_TEST_SECRET_KEY'],
    :client_id       => ENV['CLIENT_ID']
}

Stripe.api_key = Rails.configuration.stripe[:secret_key]
STRIPE_PUBLIC_KEY = Rails.configuration.stripe[:publishable_key]