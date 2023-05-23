class ArticlesController < ApplicationController
  def index
    @articles = Article.where("status = ?", "public").order("id DESC").limit(3)
  end

  def show
    @article = Article.find(params[:id])
  end
end
