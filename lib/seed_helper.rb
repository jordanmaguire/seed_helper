require 'colorize'
require 'seed_helper/version'
require 'seed_helper/output_formatter'
require 'seed_helper/rake_helper'

class SeedHelper
  extend SeedHelper::OutputFormatter
  extend SeedHelper::RakeHelper

  # If a resource_class with matching identifiable_attributes exists, return that user and present a
  # resource_already_exists message.
  #
  # Otherwise, create a new instance of resource_class using the identifiable_attributes and
  # additional_attributes.
  #
  # @param [Class] resource_class: The class to create the resource in. EG: User
  # @param [Hash] identifiable_attributes: A hash of attributes and values that can be used to
  #                                        identify the given resource. EG: {email: "jordan@example.com"}
  # @param [Hash] additional_attributes: A hash of attributes and values that don't identify
  #                                      the given resource, but should be assigned to the new resource.
  def self.find_or_create_resource(resource_class, identifiable_attributes, additional_attributes={}, &constructor)
    if resource = find_resource(resource_class, identifiable_attributes)
      resource_already_exists(resource)
    else
      if constructor.present?
        resource = constructor.call
      else
        resource = resource_class.new(identifiable_attributes.merge(additional_attributes))
      end
      create_resource(resource)
    end
    return resource
  end

  def self.create_resource(resource)
    if (did_save = resource.save)
      message = "#{resource} successfully created"
      success(message)
    else
      message = "#{resource} failed to create. Errors: #{resource.errors.full_messages}"
      error(message)
    end
    did_save
  end

  def self.bulk_create(klass, &creation_block)
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

private

  def self.find_resource(resource_class, attributes)
    # Remove symbols from attributes. They cause SQL to get mad.
    cloned_attributes = Hash[ attributes.map { |k, v| [k, v.is_a?(Symbol) ? v.to_s : v] } ]
    cloned_attributes.delete_if do |key, value|
      # Can't search for password
      [:password, :password_confirmation].include?(key) ||
      # Times are bad for searches
      value.kind_of?(Time) ||
      value.kind_of?(Date) ||
      # As are arrays
      value.kind_of?(Array) ||
      # As are Files
      value.kind_of?(File)
    end
    # Rails 4
    if resource_class.respond_to?(:find_by)
      return resource_class.find_by(cloned_attributes)
    # Rails 3
    else
      return resource_class.where(cloned_attributes).first
    end
  end

end
