class SessionsController < ApplicationController
  
  def new
  end
  
  # ビューで入力したメールアドレスとパスワードはparams[:session]に入っている。
  # ユーザをメールアドレスから検索する。
  # ユーザが見つかった場合、authenticateでパスワードが正しいか調べる。
  # authenticate = 信頼できることを証明する。
  
  # パスワードが正しい場合は、session[:user_id]にユーザidを入れて、ユーザの詳細ページにリライレクトする。
  # パスワードが間違っている場合は、newを表示する。
  
  # Session#createは、SessionsControllerのcreateアクションという意味。
  def create
    @user = User.find_by(email: params[:session][:email].downcase)
    if @user && @user.authenticate(params[:session][:password])
      session[:user_id] = @user.id
      flash[:info] = "logged in as #{@user.name}"
      redirect_to @user
    else
      flash[:danger] = 'invalid email/password combination'
      render 'new'
    end
  end
  
  # ログアウト時に呼び出す。
  # session[:user_id]をnilにする。これで、サーバーとブラウザの両方でセッションの情報が破棄される。
  # rootにリダイレクトする。
  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
end
