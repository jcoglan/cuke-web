require 'capybara/cucumber'
require 'rack/proxy'

class CukeWebProxy < Rack::Proxy
  def rewrite_env(env)
    env['HTTP_HOST'] = '0.0.0.0'
    env['SERVER_PORT'] = '9022'
    env
  end
end

Capybara.app = CukeWebProxy.new

