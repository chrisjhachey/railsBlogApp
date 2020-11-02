class ArticlesController < ApplicationController
    before_action :set_article, only: [:show, :edit, :update] # Runs set_article before any of these methods
    before_action :require_user, except: [:show, :index]    # calls method from application_controller that confirms a user is logge din to get to certain urls
    before_action :require_same_user, only: [:edit, :update, :destroy]  # after ensuring there is a logged in user, only allows certain actions if the logge din user is the owner of the article

    def show
        # byebug                # Cool debugging feature that pauses the server and lets you inspect in console
    end

    def index
        @articles = Article.all
    end

    def new
        @article = Article.new
    end

    def create
        byebug
        @article = Article.new(article_params)
        @article.user = current_user

        if @article.save
            flash[:notice] = "Article was created successfully"     # this is a hash map provided by rails to help display messages
            redirect_to article_path(@article)
        else
            render 'new'
        end
    end

    def edit

    end

    def update
        if @article.update(article_params)
            flash[:notice] = "Article was updated successfully"
            redirect_to article_path(@article)
        else
            render 'edit'
        end
    end

    def destroy
        @article.destroy
        redirect_to articles_path
    end

    private 

    def set_article
        byebug
        @article = Article.find(params[:id])
    end

    def article_params
        params.require(:article).permit(:title, :description, category_ids: [])
    end

    def require_same_user
        if current_user != @article.user && !current_user.admin?
            flash[:alert] = "You can only edit or delete your own article"
            redirect_to @article
        end
    end
end