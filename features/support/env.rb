require 'capybara/cucumber'

dir = File.expand_path(File.dirname(__FILE__))
require dir + '/../../lib/cuke_web'
Capybara.app = CukeWeb.new(dir + '/../..')

