require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
  end

  test "login with invalid information" do 
    get login_path
    assert_template 'sessions/new'
    post login_path, params: { session: { name:"", password:"" } }
    assert_template 'sessions/new'
    assert_not flash.empty?
    get root_path
    assert flash.empty?
  end

  test "login with valid information followed by logout" do
    get login_path
    post login_path, params: { session: { name: @user.name, password: 'password' } }
    
    assert is_logged_in? # ログインしているか
    assert_redirected_to @user # リダイレクト先が正しいか
    follow_redirect! # そのページに実際に移動
    assert_template 'users/show'
    assert_select "a[href=?]", login_path, count: 0 # ログイン用ページが表示されなくなったか確認
    assert_select "a[href=?]", logout_path
    assert_select "a[href=?]", user_path(@user)
    delete logout_path # ログアウトする
    assert_not is_logged_in? # ログインしていないか
    assert_redirected_to root_url # リダイレクト先が正しいか
    follow_redirect! # root urlにリダイレクト
    assert_select "a[href=?]", login_path # ログインパスがあるか
    assert_select "a[href=?]", logout_path,      count: 0 # ログアウトパスがないか
    assert_select "a[href=?]", user_path(@user), count: 0 # ユーザーページがないか
  end
end
