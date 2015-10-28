class UsersController < ApplicationController
  
  before_action :set_user, only: [:show, :edit, :update, :followings, :followers]
  
  def show
    @microposts = @user.microposts.page(params[:page]).per(10).order(created_at: :desc)
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
      flash[:success] = "Welcome to the Sample App!"
      redirect_to user_path(@user)
    else
      render 'new'
    end
  end
  
  def edit

  end
  
  def update
    if @user.update(user_params)
      flash[:success] =  "更新しました！"
      redirect_to user_path
    else
      # 保存に失敗した場合は編集画面に戻す。
      render 'edit'
    end
  end
  
  def followings
    @followings = @user.following_users
  end
  
  def followers
    @followers = @user.follower_users
  end
  
  
  private
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :place, :profile)
    end
    
    def set_user
      @user = User.find(params[:id])
    end
  
end
