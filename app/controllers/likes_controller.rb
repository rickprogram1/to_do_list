class LikesController < ApplicationController
  before_action :logged_in_user

  def create
    @task = Task.find(params[:task_id])
    unless @task.iine?(current_user)
      @task.iine(current_user)
      @task.reload
      respond_to do |format|
        format.html { redirect_to request.referrer || root_url}
        format.js
      end
    end
  end

  def destroy
    @task = Like.find(params[:id]).task
    if @task.iine?(current_user)
      @task.uniine(current_user)
      @task.reload
      respond_to do |format|
        format.html { redirect_to request.referrer || root_url }
        format.js
      end
    end
  end
end
