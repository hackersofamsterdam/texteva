require 'active_support/core_ext/string'

class CommandLoader
  def initialize(bot)
    @bot = bot
    @excluded = %w(command.rb)
  end

  def commands
    Dir[File.join('./lib/commands', '**', '*.rb')].map { |file|
      # Skip the base command file
      next if @excluded.include?(File.basename(file))

      get_class(file, @bot)
    }.compact
  end

  def get_class(file, params)
    require file
    class_name(file).constantize.new(*params)
  end

  def class_name(file)
    File.basename(file, '.rb').classify
  end
end
