require 'sinatra'
require 'sinatra/reloader'
require 'csv'
require_relative 'app/models/article.rb'
require 'pry'

#configure :development, :test do
#end

Dir[File.join(File.dirname(__FILE__), 'lib', '**', '*.rb')].each do |file|
  require file
  also_reload file
end

get '/' do
  @title = "Hello World"
  erb :index
end

get '/articles/new' do

  erb :new
end

post '/new' do

  redirect '/'
end
