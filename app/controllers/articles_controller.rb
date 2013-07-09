class ArticlesController < ApplicationController

  # TODO: escape html on create and edit

  def welcome
    @articles = [].each

    respond_to do |format|
      format.html { render 'index' }
      format.json { render json: @articles }
    end
  end
  
  def search
    @articles = Article.full_text_search(params[:q], match: :all).map! do |article|
      article.body = BlueCloth.new(article.body).to_html
      article
    end

    respond_to do |format|
      format.html { render 'index' }
      format.json { render json: @articles }
    end

  end

  def index
    @articles = Article.each

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @articles }
    end
  end

  def new
    @article = Article.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @article }
    end
  end

  def edit
    @article = Article.find(params[:id])
  end

  def create
    @article = Article.new(params[:article])

    respond_to do |format|
      if @article.save
        format.html { redirect_to action: 'welcome', notice: 'Article was successfully created.' }
        format.json { render json: @article, status: :created, location: @article }
      else
        format.html { render action: "new" }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @article = Article.find(params[:id])

    respond_to do |format|
      if @article.update_attributes(params[:article])
        format.html { redirect_to action: 'welcome', notice: 'Article was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    respond_to do |format|
      format.html { redirect_to action: 'welcome' }
      format.json { head :no_content }
    end
  end
end
