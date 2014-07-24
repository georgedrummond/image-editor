class ImageEditor

  attr_accessor :canvas, :processed_commands

  class << self
    def rule(command_key, options)
      @rules ||= []
      @rules << { command_key: command_key, options: options }
    end

    def rules
      @rules
    end
  end
  
  def initialize
    @canvas = []
    @processed_commands = []
  end

  def commands(commands)
    @processed_commands += commands.split(' ').map do |command|
      command.gsub!('>', '')
      {
        command_key: command[0],
        arguments: command[1..-1].split('').map do |argument| 
          argument =~ /\d/ ? argument.to_i : argument
        end
      }
    end
  end

  def run_commands!
    @processed_commands.each do |command|
      rule = rules.find { |rule| rule[:command_key] == command[:command_key] }
      send rule[:options][:action], *command[:arguments]
    end
  end

  def rules
    self.class.rules
  end

end
