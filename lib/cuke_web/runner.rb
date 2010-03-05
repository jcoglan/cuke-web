require 'cucumber/formatter/html'

class CukeWeb
  class Runner
    
    attr_reader :output
    
    def initialize(file, line)
      command = "cucumber #{file}:#{line} --format html"
      @output = IO.popen(command).read
    end
    
  end
end

