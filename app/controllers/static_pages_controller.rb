class StaticPagesController < ApplicationController
  
  def home
      # ログイン中にhomeへアクセスした場合、Userページへリダイレクト
      redirect_to current_user if logged_in?
  end
end
