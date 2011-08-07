require 'colored'
require 'seed_helper/version'
require 'seed_helper/output_formatter'
require 'seed_helper/rake_helper'

module SeedHelper
  include SeedHelper::OutputFormatter
  include SeedHelper::RakeHelper 

  def create_resource(resource_class, attributes)
    if resource = resource_class.find_by(attributes)
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

end
