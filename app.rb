require 'sinatra'
require 'sinatra/reloader'
require 'csv'
require 'json'
require_relative 'app/models/article.rb'
require 'pry'
require 'smarter_csv'

configure :development, :test do
end

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

get '/articles/:article' do
  @articles = create_articles_array
  @article = params[:article]
  @articles.each do |article|
    if article.id == @article
      @article = article
    end
  end

  erb :article
end


get '/json' do
  content_type :json
  @data = SmarterCSV.process('news.csv')
  @data.to_json
end

get '/article/new' do

  erb :new
end

post '/new' do
  new_article_id = create_articles_array.length + 1

  CSV.open('news.csv', 'a') do |csv|
    csv << [
      new_article_id,
      params["title_new"],
      params["description_new"],
      params["url_new"]
    ]
  end
  @title_new = params["title_new"]
  @description_new = params["description_new"]
  @url_new = params["url_new"]
  redirect "/"
end

get "/" do
  redirect "/articles"
end
