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
    # Rails 4
    if resource_class.respond_to?(:find_by)
      return resource_class.find_by(attributes)
    # Rails 3
    else
      return resource_class.where(attributes).first
    end
  end

end
