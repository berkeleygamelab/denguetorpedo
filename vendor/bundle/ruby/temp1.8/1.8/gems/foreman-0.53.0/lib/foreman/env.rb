require "foreman"

class Foreman::Env

  attr_reader :entries

  def initialize(filename)
    @entries = File.read(filename).split("\n").inject({}) do |ax, line|
      if line =~ /\A([A-Za-z_0-9]+)=(.*)\z/
        key = $1
        case val = $2
          when /\A'(.*)'\z/ then ax[key] = $1
          when /\A"(.*)"\z/ then ax[key] = $1.gsub(/\\(.)/, '\1')
          else ax[key] = val
        end
      end
      ax
    end
  end

  def entries
    @entries.each do |key, value|
      yield key, value
    end
  end

end