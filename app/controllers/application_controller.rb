class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  
  protect_from_forgery with: :exception
  
  # 自作したモジュールを読み込む
  include SessionsHelper
  
  private
  def logg_user
    # logged_in がfalseの時のみ以下の処理を行う。
    unless logged_in?
      store_location
      flash[:danger] = "Please log in."
      redirect_to login_url
    end
  end
end
