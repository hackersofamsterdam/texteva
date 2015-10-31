class UpdateDispatcher
  # @param [CommandLoader] command_loader
  def initialize(command_loader)
    @commands = command_loader.commands
  end

  def dispatch(update)
    # @type [Command] command
    @commands.each do |command|
      command.set_update update
      return command.invoke! if command.matches?
    end

    raise NoReplyError
  end
end
