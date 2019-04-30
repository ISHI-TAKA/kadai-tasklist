class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception
    def index
        @tasks = task.all
    end
 
    def show
        @tasks = task.find(params[:id]) 
    end   
 
    def new
        @tasks = task.new
    end   
 
    def create
        @task = task.new(task_params)
        
        if @task.save
            flash[:success] = 'taskが正常に投稿されました'
            redirect_to @task
        else
            flash.now[:danger] = 'taskが投稿されませんでした'
            render :new
        end
    end   
 
    def edit
        @task = task.find(params[@id])
    end   
 
    def update
        @task = task.find(params[:id])
        
        if @task.update(task_params)
            flash[:success] = 'taskは正常に更新されました'
            redirect_to @task
        else
            flash.now[:danger] = 'taskは更新されませんでした'
            render :edit
        end
    end   
 
    def destroy
        @task = task.find(params[:id])
        @task.destroy
        
        flash[:success] = 'taskは正常に削除されました'
        redirect_to task_url
    end   

    include SessionsHelper

    private
    
    #Strong Parameter
    def task_params
        params.require(:task).permit(:content)
    end
    
    def require_user_logged_in
      unless logged_in?
      redirect_to login_url
      end
    end
end