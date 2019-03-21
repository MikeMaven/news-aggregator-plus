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

get '/articles-data.json' do
  binding.pry
  content_type :json
  articles = create_articles_array
  articles_data = {articles: []}
  articles.each do |article|
    article_data = {}
    article_data[:id] = article.id
    article_data[:title] = article.title
    article_data[:description] = article.description
    article_data[:url] = article.url
    articles_data[:articles].push(article_data)
   end
   articles_data.to_json

end

get '/json' do
  content_type :json
  @data = SmarterCSV.process('news.csv')
  @data.to_json
end

get '/articles/new' do

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
  redirect "/"
end

get "/" do
  redirect "/articles"
end
