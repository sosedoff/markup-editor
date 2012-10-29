require 'bundler/setup'
require 'docify'
require 'sinatra'
require './app/lib/highlight'

VERSION = '0.3.2'

configure do
  set :views, 'app/views'
end

configure :production do
  set :show_exceptions, false
  set :dump_errors,     false
  set :raise_errors,    false
end

helpers do
  def app_version
    VERSION
  end
end

get '/' do
  erb :editor
end

get '/sample' do
  @content = File.read(File.join(settings.root, 'README.md'))
  erb :editor
end

post '/render' do
  content = params[:content].to_s
  markup  = params[:markup] || 'markdown'

  if content.empty?
    return ""
  end

  if !Docify.valid_format?(params[:markup])
    halt 400, "Invalid markup"
  end

  Highlight.render(content, markup)
end