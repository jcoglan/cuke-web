require 'sinatra'

class CukeWeb < Sinatra::Base
  def initialize(path)
    super()
    @path = File.expand_path(path)  
  end
  
  get '/' do
    'Welcome to CukeWeb'
  end
end

