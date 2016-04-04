module SeedHelper::BulkCreate

  def bulk_create(klass, &creation_block)
    klass_plural = klass.name.pluralize

    if klass.any?
      resource_already_exists(klass_plural)
    else
      begin
        creation_block.call
        success("Created #{klass_plural}")
      rescue
        error("Failed to create #{klass_plural}: #{$!}")
      end
    end
  end

end
