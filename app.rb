require 'bundler/setup'
require 'docify'
require 'sinatra'

VERSION = '0.1.0'

configure do
  set :views, 'app/views'
end

helpers do
  def app_version
    VERSION
  end
end

get '/' do
  erb :editor
end

post '/render' do
  begin
    Docify.render(params[:content], params[:markup])
  rescue Exception => ex
    "Request failder: #{ex.inspect}"
  end
end