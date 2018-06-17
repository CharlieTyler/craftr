class Admin::StaticPagesController < AdminController
  def dashboard
    @test_products = Product.where(is_test: true)
    @test_distilleries = Distillery.where(is_test: true)
  end

  def reports

  end
end
