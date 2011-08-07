require "seed_formatter/version"
require "colored"

module SeedFormatter
  class << self
        
    # Outputs a message with a set of given options
    #
    # @param [String] message: The message to format
    # @param [Hash] options: A hash of options to apply to the string
    # @option options [String] prefix: A prefix for the message. EG: "--> message"
    # @option options [String] color: A Symbol representing the color from the Colored gem. See: Colored.colors
    # @option options [String] suffix: A String suffix for the message. EG: "message !!!"
    #
    # @example Print out an error message
    #   SeedFormatter.output "Some error", {:prefix => "!!! ", :color => :red}
    #   # outputs "!!! Some error" in red text
    #
    def output message, options
      puts "#{options[:prefix]}#{message}#{options[:suffix]}".send(options[:color])
    end
    
    # A preset formatter with overridable options
    def message message, options = {}
      options[:prefix] ||= "*** "
      options[:color] ||= :white
      output message, options
    end
    
    # A preset formatter with overridable options
    def success message, options = {}
      options[:prefix] ||= "  + "
      options[:color] ||= :green
      output message, options
    end
    
    # A preset formatter with overridable options
    def error message, options = {}
      options[:prefix] ||= "  - "
      options[:color] ||= :red
      output message, options
    end
  end
end
