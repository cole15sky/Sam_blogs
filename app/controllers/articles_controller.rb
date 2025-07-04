class ArticlesController < ApplicationController
  before_action :set_article, only: %i[show edit update destroy]
  before_action :authenticate_user!, only: [ :new, :create, :edit, :update, :destroy ]

  def index
    @articles = user_signed_in? ? Article.sorted : Article.published.sorted
  end

  def show
  end

  def new
    @article = Article.new
  end

  def edit
  end

  def create
    @article = Article.new(article_params)
    if @article.save
      redirect_to @article, notice: "Article was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @article.update(article_params)
      redirect_to @article, notice: "Article was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @article.destroy
    redirect_to articles_path, notice: "Article was successfully deleted."
  end

  private

  def set_article
    if user_signed_in?
      @article = Article.find(params[:id])
    else
      @article = Article.published.find(params[:id])
    end
  end

  def article_params
    params.require(:article).permit(:title, :content, :published_at)
  end
end
