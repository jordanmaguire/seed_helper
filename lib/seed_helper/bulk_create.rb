module SeedHelper::BulkCreate

  # Allow an easy means of using something like FactoryGirl.create_list to seed a number
  # of records.
  #
  # If any instances of resource_class with matching identifiable_attributes exists, present a
  # resource_already_exists message.
  #
  # Otherwise, run the provided creation_block.
  #
  # @param [Class] resource_class: The class to create the resource in. EG: User
  # @param [Hash] identifiable_attributes: A hash of attributes and values that can be used to
  #                                        identify the given resource. EG: {email: "jordan@example.com"}
  # @params [Proc] creation_block: A block that will create some objects
  def bulk_create(klass, identifiable_attributes={}, &creation_block)
    message_identifier = bulk_create_message_identifier(klass, identifiable_attributes)

    if klass.where(identifiable_attributes).exists?
      resource_already_exists(message_identifier)
    else
      begin
        creation_block.call(identifiable_attributes)
        success("Created #{message_identifier}")
      rescue
        error("Failed to create #{message_identifier}: #{$!}")
      end
    end
  end

private

  def bulk_create_message_identifier(klass, identifiable_attributes)
    klass_plural = klass.name.pluralize

    if identifiable_attributes.any?
      "#{klass_plural} (#{identifiable_attributes})"
    else
      klass_plural
    end
  end

end
