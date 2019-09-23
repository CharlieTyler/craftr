desc "This task batches all postages by distiller and creates the scan_form. This is required because Easypost batch daily and do not group by the ship_from address, so we have to beat them to it."
task :create_batches_for_each_distillery => :environment do
  # For each transactional distillery
  Distillery.transactional.each do |distillery|
    puts "Batching for #{distillery.name}..."
    distiller_sold_items = distillery.sold_items.where(manual_shipping: [nil, false], batch_id: nil)
    batch_counter = 0

    # If it's got auto postage sold_items to batch
    if distiller_sold_items.length > 0
      # Create a batch in easypost
      easypost_batch = EasyPost::Batch.create()

      # Mimic it in local database, with the easypost_batch_id saved
      batch = distillery.batches.create(easypost_batch_id: easypost_batch.id)

      distiller_sold_items.each do |si|
        si.postages.each do |postage|
          # check if it's been batched on easypost (shouldn't have been)
          shipment = EasyPost::Shipment.retrieve(postage.easypost_shipment_id)
          if shipment.present?
            if shipment.batch_id.present?
              # reflect locally if has been batched
              postage.batch_locally_if_batched_on_easypost
            else
              # Add these postages to the batch
              easypost_batch.add_shipments({shipments: [{id: postage.easypost_shipment_id}]})
              batch_counter += 1
              # And reflect locally
              si.update_attributes(batch_id: batch.id)
            end
          end
        end

        # If stuff has been added, create the bloody scanform and save it.
        if batch_counter > 0
          scan_form = easypost_batch.create_scan_form()
          batch.update_attributes(scanform_created_at: Time.now.in_time_zone('London'), scanform_id: scan_form[:scan_form][:id])
          puts "Batched #{batch_counter} items"
        # Otherwise delete it and send back to dashboard - nothing to see here
        else
          batch.delete
          puts "Already been batched"
        end
      end
    else
      puts "Nothing here :("
    end
  end  
end