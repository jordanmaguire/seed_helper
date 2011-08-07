require "seed_formatter/version"
require "colored"

module SeedFormatter
  class << self
    ## Colored.colors is an array of strings representing the available colours.
    def output message, color, options
      puts "#{options[:prefix]}#{message}#{options[:suffix]}".send(color)
    end
  
    def message message, options = {}
      options[:prefix] ||= "*** "
      options[:color] ||= :white
      output message, options[:color], options
    end
    
    def success message, options = {}
      options[:prefix] ||= "  + "
      options[:color] ||= :green
      output message, options[:color], options
    end
    
    def error message, options = {}
      options[:prefix] ||= "  - "
      options[:color] ||= :red
      output message, options[:color], options
    end
  end
end
