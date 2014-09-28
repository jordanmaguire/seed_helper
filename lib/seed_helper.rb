require 'colored'
require 'seed_helper/version'
require 'seed_helper/output_formatter'
require 'seed_helper/rake_helper'

module SeedHelper
  include SeedHelper::OutputFormatter
  include SeedHelper::RakeHelper 

  def create_resource(resource_class, attributes)
    if resource = find_resource(resource_class, attributes)
      resource_already_exists(resource)
    else
      resource = resource_class.new(attributes)
      if resource.save
        message = "#{resource} successfully created"
        success(message)
      else
        message = "#{resource} failed to create. Errors: #{resource.errors.full_messages}"
        error(message)
      end
    end
    return resource
  end

private

  def find_resource(resource_class, attributes)
    # Remove symbols from attributes. They cause SQL to get mad.
    cloned_attributes = Hash[ attributes.map { |k, v| [k, v.is_a?(Symbol) ? v.to_s : v] } ]
    cloned_attributes.delete_if do |key, value|
      # Can't search for password
      [:password, :password_confirmation].include?(key) ||
      # Times are bad for searches
      value.kind_of?(Time) ||
      value.kind_of?(Date)
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
