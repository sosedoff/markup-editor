require 'rubygems'
require 'bundler'
require 'rack'
require 'rack/contrib'

Bundler.require

use Rack::Runtime
use Rack::BounceFavicon

require './app.rb'
run Sinatra::Application