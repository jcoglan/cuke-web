require 'sinatra'
require 'cucumber'

class CukeWeb < Sinatra::Base
  
  ROOT_DIR = File.expand_path(File.dirname(__FILE__))
  set :root, ROOT_DIR
  set :static, true
  
  require ROOT_DIR + '/cuke_web/formatter'
  require ROOT_DIR + '/cuke_web/runner'
  
  def initialize(path)
    super()
    @path = File.expand_path(path)
    
    @step_mother = Cucumber::StepMother.new
    @config = Cucumber::Cli::Configuration.new
    @config.parse!([@path])
    
    @step_mother.load_code_files(@config.step_defs_to_load)
  end
  
  def feature_files
    @config.feature_files.sort
  end
  
  get '/' do
    @feature_files = feature_files.map do |path|
      path.gsub(@path + '/', '').
           gsub(/\.feature$/, '')
    end
    erb :index
  end
  
  get '/features/:n' do |n|
    @feature_file = feature_files[n.to_i - 1]
    @formatter = Formatter.new(@step_mother, :file => @feature_file)
    erb :feature
  end
  
  get '/steps/*' do
    @definition_file = File.join(@path, params[:splat].first)
    @lines = File.read(@definition_file).split(/\n/)
    erb :definition_file
  end
  
  get '/tags/:tag' do
    @tag = params[:tag]
    @formatter = Formatter.new(@step_mother, :tag => @tag, :files => feature_files)
    erb :tag
  end
  
  get '/run/*' do
    parts = params[:splat].first.split('/')
    line = parts.pop
    Runner.new('/' + File.join(*parts), line).output
  end
  
end

