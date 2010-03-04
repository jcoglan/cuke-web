require 'sinatra'

class CukeWeb < Sinatra::Base
  
  ROOT_DIR = File.expand_path(File.dirname(__FILE__))
  set :root, ROOT_DIR
  
  def initialize(path)
    super()
    @path = File.expand_path(path)
  end
  
  def feature_files
    conf = Cucumber::Cli::Configuration.new
    conf.parse!([@path])
    conf.feature_files
  end
  
  get '/' do
    @feature_files = feature_files
    erb :index
  end
  
end

