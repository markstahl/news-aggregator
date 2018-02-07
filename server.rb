require "sinatra"
require "sinatra/reloader"
require "csv"
require "pry"
require "erb"

require_relative "models/article"

set :bind, '0.0.0.0'

def article_list
  articles = []
  CSV.foreach('articles.csv') do |row|
    articles << Article.new(row[0], row[1], row[2])
  end
  return articles
end

get "/" do
  redirect "/articles"
end

get "/articles" do
  @articles = article_list
  erb :articles
end

get "/articles/new" do
  erb :submit_article
end

post "/articles/new" do
  @article_title = params['article_title']
  @description = params['description']
  @url = params['url']
   if @article_title && @description && @url != ""
     CSV.open("articles.csv", "a") do |csv|
    article = Article.new(@article_title, @url, @description)
      csv << [article.article_title, article.url, article.description]
    end
    redirect "/articles"
  else
    @error = "Please fill out all forms ya turkey!"
    erb :submit_article
  end
end
