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

helpers do
  def partial error
    erb :error, :layout => false
  end
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
  new_article = true
  valid_submission = true
  valid_url = true
  valid_description = false
  articles = create_articles_array
  articles.each do |article|
    if params["url_new"] == article.url
      new_article = false
    end
  end

  if params["title_new"] == "" || params["description_new"] == "" || params["url_new"] == ""
    valid_submission = false
  end

  if params["description_new"].length >= 20
    valid_description = true
  end

  if params["url_new"] != "" && params["url_new"].start_with?("http") == false
    valid_url = false
  end

  if new_article == true && valid_submission == true && valid_url == true && valid_description == true
    CSV.open('news.csv', 'a') do |csv|
      csv << [
        new_article_id,
        params["title_new"],
        params["description_new"],
        params["url_new"]
      ]
    end

    redirect "/"
  else
    @title_new = params["title_new"]
    @description_new = params["description_new"]
    @url_new = params["url_new"]
    if valid_submission == false
      @error_message = "Error: Please fill out every field"
    elsif valid_submission == true && valid_url == true && new_article == false
      @error_message = "Error: Please be original"
    elsif valid_submission == true && valid_url == true && new_article == true && valid_description == false
      @error_message = "Error: Please provide a longer description"
    elsif valid_submission == true && valid_url == false
      @error_message = "Error: Please provide a valid url"
    end

    erb :new
  end
end

get "/" do

  redirect "/articles"
end
