require "foreman"
require "rubygems"

class Foreman::Process

  attr_reader :command
  attr_reader :env

  # Create a Process
  #
  # @param [String] command  The command to run
  # @param [Hash]   options
  #
  # @option options [String] :cwd (./)  Change to this working directory before executing the process
  # @option options [Hash]   :env ({})  Environment variables to set for this process
  #
  def initialize(command, options={})
    @command = command
    @options = options.dup

    @options[:env] ||= {}
  end

  # Run a +Process+
  #
  # @param [Hash] options
  #
  # @option options :env    ({})       Environment variables to set for this execution
  # @option options :output ($stdout)  The output stream
  #
  # @returns [Fixnum] pid  The +pid+ of the process
  #
  def run(options={})
    env    = options[:env] ? @options[:env].merge(options[:env]) : @options[:env]
    output = options[:output] || $stdout

    if Foreman.windows?
      Dir.chdir(cwd) do
        expanded_command = command.dup
        env.each do |key, val|
          expanded_command.gsub!("$#{key}", val)
        end
        Process.spawn env, expanded_command, :out => output, :err => output
      end
    elsif Foreman.jruby?
      require "posix/spawn"
      wrapped_command = "#{Foreman.runner} -d '#{cwd}' -p -- #{command}"
      POSIX::Spawn.spawn env, wrapped_command, :out => output, :err => output
    elsif Foreman.ruby_18?
      fork do
        $stdout.reopen output
        $stderr.reopen output
        env.each { |k,v| ENV[k] = v }
        wrapped_command = "#{Foreman.runner} -d '#{cwd}' -p -- #{command}"
        exec wrapped_command
      end
    else
      wrapped_command = "#{Foreman.runner} -d '#{cwd}' -p -- #{command}"
      Process.spawn env, wrapped_command, :out => output, :err => output
    end
  end

  # Send a signal to this +Process+
  #
  # @param [String] signal  The signal to send
  #
  def kill(signal)
    if Foreman.windows?
      pid && Process.kill(signal, pid)
    else
      pid && Process.kill("-#{signal}", pid)
    end
  rescue Errno::ESRCH
    false
  end

  # Test whether or not this +Process+ is still running
  #
  # @returns [Boolean]
  #
  def alive?
    kill(0)
  end

  # Test whether or not this +Process+ has terminated
  #
  # @returns [Boolean]
  #
  def dead?
    !alive?
  end

  # Returns the working directory for this +Process+
  #
  # @returns [String]
  #
  def cwd
    File.expand_path(@options[:cwd] || ".")
  end

end
