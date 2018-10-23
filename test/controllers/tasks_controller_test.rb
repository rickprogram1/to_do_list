require 'test_helper'

class TasksControllerTest < ActionDispatch::IntegrationTest
  
  def setup
    @task = tasks(:orange)
  end

  test "should redirect index when not logged in" do
    get tasks_path
    assert_redirected_to login_url
  end

  test "index including pagination" do
    log_in_as(users(:michael))
    get tasks_path
    assert_template 'tasks/index'
    assert_select 'div.pagination'
    Task.paginate(page: 1).each do |task|
      assert_select 'a[href=?]', user_path(task.user), text: task.user.name
    end 
  end

  test "should redirect create when not logged in" do
    assert_no_difference 'Task.count' do
      post tasks_path, params: { task: { content: "Lorem ipsum" } }
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'Task.count' do
      delete task_path(@task)
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy for wrong task" do
  log_in_as(users(:michael))
  task = tasks(:ants)
	assert_no_difference 'Task.count' do
		delete task_path(task)
	end
	assert_redirected_to root_url
	end
end
