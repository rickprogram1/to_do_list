class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  # Sessionモジュールを読み込ませる

  def hello
    render html: "hello, world!"
  end
end
