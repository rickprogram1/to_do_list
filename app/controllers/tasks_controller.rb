class TasksController < ApplicationController
	before_action :logged_in_user, only: [:index, :create, :edit, :destroy]
	before_action :correct_user, only: [:edit, :destroy]

	def index
		@tasks = Task.where(done: false).paginate(page: params[:page])
	end

	def create
		@task = current_user.tasks.build(task_params)
		if @task.save
			flash[:success] = "Task created!"
			redirect_to root_url
		else
			# task投稿時に失敗で再表示
			@user = current_user
			@tasks = @user.tasks.paginate(page: params[:page])
			render 'users/show'
		end
	end

	def edit
	end

	def update
		@task = current_user.tasks.find(params[:id])
		@user = current_user
		#未チェックの場合
		if !@task.done && request.put?
		  @task.update_attributes(done: true)
			#Ajaxリクエスト対応
			respond_to do |format|
				format.html { redirect_to @user || root_url }
				format.js
			end
		# editしたとき
		elsif !@task.done && request.patch?
			@task.update_attributes(task_params)
      flash[:success] = "task updated"
      redirect_to @user || root_url
		#チェック済みの場合
		else
			@task.update_attributes(done: false)
			#Ajaxリクエスト対応
			respond_to do |format|
				format.html { redirect_to @user || root_url }
				format.js
			end
		end
	end
	
	def destroy
		@task.destroy
		flash[:success] = "Task deleted"
		redirect_to request.referrer || root_url
	end

	private

		def task_params
			params.require(:task).permit(:content, :priority)
		end

		def correct_user
			@task = current_user.tasks.find_by(id: params[:id])
			redirect_to root_url if @task.nil?
		end
end
