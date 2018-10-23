class StaticPagesController < ApplicationController
  
  def home
    if logged_in?
      # ログイン中にhomeへアクセスした場合、Userページへリダイレクト
      redirect_to current_user
    end
  end
end
