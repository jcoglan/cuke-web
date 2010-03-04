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
    @feature_files = feature_files.map { |path| path.gsub(@path + '/', '') }
    erb :index
  end
  
  get '/features/:n' do |n|
    @feature_file = feature_files[n.to_i - 1]
    @feature_text = File.read(@feature_file)
    erb :feature
  end
  
end

