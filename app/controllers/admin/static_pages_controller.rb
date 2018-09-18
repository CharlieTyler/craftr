class Admin::StaticPagesController < AdminController
  def dashboard
    @unshipped_batches = Batch.where(shipped: false).order("created_at DESC")
    @unbatched_sold_items_with_postage_label = SoldItem.where(batch_id: nil, shipping_label_created: true).order("created_at DESC")
    @unbatched_sold_items_without_postage_label = SoldItem.where(batch_id: nil, shipping_label_created: false).order("created_at DESC")
  end

  def reports

  end

  def control_panel
    @test_products = Product.where(is_test: true)
    @test_distilleries = Distillery.where(is_test: true)
  end
end
