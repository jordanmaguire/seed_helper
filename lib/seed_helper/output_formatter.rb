module SeedHelper::OutputFormatter

  # Outputs a message with a set of given options
  #
  # @param [String] message: The message to format
  # @param [Hash] options: A hash of options to apply to the string
  # @option options [String] prefix: A prefix for the message. EG: "--> message"
  # @option options [String] color: A Symbol representing the color from the Colored gem. See: Colored.colors
  # @option options [String] suffix: A String suffix for the message. EG: "message !!!"
  #
  # @example Print out an error message
  #   SeedHelper.output "Some error", {:prefix => "!!! ", :color => :red}
  #   # outputs "!!! Some error" in red text
  def output(message, options = {})
    options[:color] ||= :white
    $stdout.puts "#{options[:prefix]}#{message}#{options[:suffix]}".send(options[:color])
  end

  def message(message, options = {})
    options[:prefix] ||= "*** "
    options[:color] ||= :white
    output message, options
  end

  def success(message, options = {})
    options[:prefix] ||= "  + "
    options[:color] ||= :green
    output message, options
  end

  def error(message, options = {})
    options[:prefix] ||= "  - "
    options[:color] ||= :red
    output message, options
  end

  def resource_already_exists(resource)
    message = "#{resource} already exists"

    options = {}
    options[:prefix] ||= "  > "
    options[:color]  ||= :cyan
    output(message, options)
  end

  def special_message(*lines)
    $stdout.puts ""
    $stdout.puts lines.join("\n  ").magenta
  end

  def print_new_line
    $stdout.puts ""
  end

end