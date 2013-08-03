class ArticlesController < ApplicationController

  skip_before_filter :require_login, :except => [:new, :edit, :create, :update, :destroy]

  def welcome

    @articles = [].each
    respond_to do |format|
      format.html { render 'index' }
      format.json { render json: @articles }
    end
  end
  
  def search
    respond_to do |format|
      format.html do
        @articles = Article.full_text_search(params[:q], match: :all).map do |article|
          article.body = BlueCloth.new(CGI::escapeHTML article.body).to_html
          article
        end
        render 'index'
      end
      format.json do 
        @articles = Article.each
        render json: @articles 
      end
    end
  end

  def index
    respond_to do |format|
      format.html do
        @articles = Article.each.map do |article|
          article.body = BlueCloth.new(CGI::escapeHTML article.body).to_html
          article
        end
      end
      format.json do 
        @articles = Article.each
        render json: @articles 
      end
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
    @article = Article.find_by(permalink: params[:permalink])
  end

  def create
    @article = Article.new(params[:article])

    respond_to do |format|
      if @article.save
        format.html { 
          flash[:notice] = 'Article was successfully created.'
          redirect_to action: 'welcome'
        }
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
        format.html { 
          flash[:notice] = 'Article was successfully updated.'
          redirect_to action: 'welcome'
        }
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
      format.html { 
        flash[:notice] = 'Article was successfully deleted.'
        redirect_to action: 'welcome' 
      }
      format.json { head :no_content }
    end
  end

  def new_import

  end

  def import
    begin
      jsoned_articles = JSON.parse(params[:jsoned_articles])
    rescue
      respond_to do |format|
        format.html { 
          flash.now[:error] = 'Not valid Json'
          render action: "new_import" 
        }
      end
      return
    end

    valid_articles = [] 
    @invalid_articles = [] 

    jsoned_articles.each_with_index do |article, index|
      article = Article.new(article)

      if article.valid?
        valid_articles << article
      else
        article.instance_variable_set(:@index, index)
        @invalid_articles << article

      end
    end

    respond_to do |format|

      if @invalid_articles.empty?
        valid_articles.each do |article|
          article.save
        end

        format.html { 
          flash[:notice] = "#{valid_articles.count} article were successfully created."
          redirect_to action: 'welcome'
        }

      else
        format.html { render action: "new_import" }
      end
    end

  end
end
