require 'bundler/setup'
require 'docify'
require 'sinatra'
require './app/lib/highlight'

VERSION = '0.3.1'

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
  markup  = params[:markup].to_s
  
  halt 400, "Content required" if content.empty?
  halt 400, "Markup required"  if markup.empty?
  halt 400, "Invalid markup"   if !Docify.valid_format?(params[:markup])

  Highlight.render(content, markup)
end