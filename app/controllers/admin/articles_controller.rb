class Admin::ArticlesController < ApplicationController
  def index
    @articles = Article.all.order("id DESC").limit(10)
  end

  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
  end

  def edit
    @article = Article.find(params[:id])
  end

  def create
    @article = Article.new(article_params)

    if @article.save
      redirect_to [:admin, @article]
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @article = Article.find(params[:id])

    if @article.update(article_params)
      redirect_to [:admin, @article]
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    redirect_to admin_articles_path, status: :see_other
  end

  private

  def article_params
    params.require(:article).permit(:title, :body, :status)
  end
end
