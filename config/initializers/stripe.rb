Rails.configuration.stripe = {
    :publishable_key => Rails.env.production? ? ENV['STRIPE_LIVE_PUBLISHABLE_KEY'] : ENV['STRIPE_TEST_PUBLISHABLE_KEY'],
    :secret_key      => Rails.env.production? ? ENV['STRIPE_LIVE_SECRET_KEY'] : ENV['STRIPE_TEST_SECRET_KEY'],
    :client_id       => Rails.env.production? ? ENV['STRIPE_LIVE_CLIENT_ID'] : ENV['STRIPE_TEST_CLIENT_ID'],
    :signing_key       => Rails.env.production? ? ENV['STRIPE_LIVE_SIGNING_KEY'] : ENV['STRIPE_TEST_SIGNING_KEY'],
}

Stripe.client_id = Rails.configuration.stripe[:client_id]
Stripe.api_key = Rails.configuration.stripe[:secret_key]
STRIPE_PUBLIC_KEY = Rails.configuration.stripe[:publishable_key]
StripeEvent.signing_secret =  Rails.configuration.stripe[:signing_key]

StripeEvent.configure do |events|
	events.subscribe 'payment_intent.succeeded' do |event|
		payment_intent = event.data.object # contains a Stripe::PaymentIntent
	    puts "Payment for #{payment_intent['amount']} succeeded."
	    puts "Charge ID - #{payment_intent.charges.data.first.id}."
	    
	    puts "Order ID - #{payment_intent.metadata.order_id}."
	    

	    order = Order.find(payment_intent.metadata.order_id)

	    puts "Order paid - #{order.paid}"

	    if order.paid == false

	    	order.update_attributes(paid: true)

	    	puts "Order ID - #{payment_intent.metadata.order_id} - start fulfillment"
	    	
		    charge = payment_intent.charges.data.first.id

		    order.order_items.each do |oi|
		      transfer = Stripe::Transfer.create({
		        :amount => oi.product.distillery_take * oi.quantity,
		        :currency => "gbp",
		        # Source transaction means payment doesn't go out until funds are processed. Also means trasfer group param not necessary
		        :source_transaction => charge,
		        :destination => oi.product.distillery.stripe_id,
		      })
		    end

		    # BACKEND STUFF
		    order.denormalise_order
		    # Uses worker server to send email
		    order.queue_confirmation_email
		    order.queue_distiller_emails
		    order.queue_distiller_reminder_emails
		    order.queue_please_review_email
		    order.queue_admin_emails
		else 
		  	puts "Order ID - #{payment_intent.metadata.order_id} - already paid"
	    end

	end

	events.subscribe 'charge.succeeded' do |event|
		puts "Success - charge"
	end

  events.all do |event|
    # Handle all event types - logging, etc.
    puts "I got a webhook from stripe. Type - #{event.type}. ID - #{event.id}"
  end
end