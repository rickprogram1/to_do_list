require 'test_helper'

class TasksInterfaceTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
  end

  test "task interface" do
    log_in_as(@user)
    get user_path(@user)# 変更
    assert_select 'div.pagination'
    # 無効な送信
    assert_no_difference 'Task.count' do
      post tasks_path, params: { task: { content: "" } }
    end
    assert_select 'div#error_explanation'
    # 有効な送信
    content = "This task really ties the room together"
    assert_difference 'Task.count', 1 do
      post tasks_path, params: {task: { content: content } }
    end
    assert_redirected_to root_url
    follow_redirect!
    assert_redirected_to user_path(@user)# 追加
    follow_redirect!# 追加
    assert_match content, response.body
    # 投稿を削除する
    assert_select 'a', text: 'delete'
    first_task = @user.tasks.paginate(page: 1).first
    assert_difference 'Task.count', -1 do
      delete task_path(first_task)
    end
    # 違うユーザーのプロフィールにアクセス (削除リンクがないことを確認)
    get user_path(users(:archer))
    assert_select 'a', text: 'delete', count: 0
  end
end
