class Distiller::DetailsController < DistillersController
  def transactional_checklist
    # current_distillery set as helper method in Distillers Controller
    @address = Address.new
  end
end
