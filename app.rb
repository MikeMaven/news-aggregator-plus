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
require_relative 'app/models/article.rb'

def create_articles_array
  articles = []
  CSV.foreach('news.csv', headers: true) do |row|
    articles << Article.new(
      row['id'],
      row['title'],
      row['description'],
      row['url']
    )
  end
  articles
end

get '/articles' do
  @articles = create_articles_array
  erb :articles
end

get '/articles/new' do

  erb :new
end

post '/new' do

  redirect '/'
end
