class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end
  
  def new
    # 以下で、Userクラスの新しいインスタンスを作成して、
    # UsersControllerのインスタンス変数@userに代入している。
    @user = User.new
  end
  # createの部分で送信されたパラメータの内容をもとに新しい@userのデータを生成する。
  def create
    @user = User.new(user_params)
    if @user.save
      # redirect_to user_path(@user)と同じ
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render 'new'
    end
  end
  
  private
  # ストローングパラメータでpasswordとpassword_confirmationというデータベースにない属性を指定していることに注意
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
    
end
