class Admin::StaticPagesController < AdminController
  def dashboard
    @unshipped_batches = Batch.where(shipped: false).order("created_at DESC")
    @unbatched_sold_items_with_postage_label = SoldItem.where(batch_id: nil, shipping_label_created: true).order("created_at DESC")
    @unbatched_sold_items_without_postage_label = SoldItem.where(batch_id: nil, shipping_label_created: false).order("created_at DESC")
    @unshipped_manual_items = SoldItem.where(manual_shipping: true, shipped: false)
    @most_recent_sold_items = SoldItem.order("created_at DESC").first(30)
    @transactional_distilleries = Distillery.transactional.order("name ASC")
    @last_30_days_sales = SoldItem.where("(created_at > ?)", Time.now.in_time_zone('London') - 30.days)
    @transactional_products = Product.transactional
    @default_shipping_price = ShippingType.first.price

    # Nil for done, because not given option when created
    @feedbacks = Feedback.where(done: nil)
  end

  def reports

  end

  def control_panel
    @test_products = Product.where(is_test: true)
    @test_distilleries = Distillery.where(is_test: true)
  end

  def product_feed_google
    @products = Product.transactional.where.not(GTIN: [nil, ""])
  end

  def product_feed_facebook
    @products = Product.transactional.where.not(GTIN: [nil, ""])
  end

  def change_distillery
    current_user.update_attributes(change_distillery_params)
    redirect_to distiller_dashboard_path
  end

  private

  def change_distillery_params
    params.require(:user).permit(:distillery_id)
  end
end
