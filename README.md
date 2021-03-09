# README

## Craftr

Marketplace for craft spirits

### Details

Rails 5.1.4

Hosted on Heroku

## TO START ON LOCAL SERVER

You need redis running - redis-server
Remove any mention of redis from application.yml
start sidekiq in seperate tab - bundle exec sidekiq
start server - rails s

Note that currently connected to same image hosting 

### Intergrations

Stripe
Sendgrid
Easy Post
Sentry
Mailchimp

Bootstrap 4 css



(c) CRAFTR LIMITED, 2021
All rights reserved.

### See site diary for updates and reasoning.

## Temporary Diary

#### 31/01/21  

- Move the creation of postages to within the distiller portal
- If is manual postage, give the option to mark each sold item as shipped
- Else tick all items that you're ready to ship (default is all ticked)
- Create postages, create batch for those postage (as per here)
- Send to batch page (which shows all shipping labels)
- On batch page, able to mark as shipped
- I think 2, 3, 5 and 6 are pretty much as is. Main change will be unpicking the views in the distiller dashboard. There's an argument to start from scratch there!

- Select orders that require postage and are ready to send
- What we are actually selecting is the sold item, as an order could contain products from different distilleries. However, we should show the same orders together somehow?
- Find sold_items 
- Show order number and what is in the order?
- Create postage and batch, including scanform
- View batches - postage labels and scanform
