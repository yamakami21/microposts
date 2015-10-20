module SessionsHelper
    # これら作ったものをcontollerで使われるようにしなければならない。
    
    # @current_user = @current_user || User.find_by(id: session[:user_id])と読み替えることができ、
    # @current_userがnilのときに、User.find_by(id: session[:user_id])を実行する。
    # User.find_by(id: session[:user_id])は、session[:user_id]の値に一致するユーザーを返します。
    # find_byメソッドは、ユーザーが見つからない場合はnilを返す。
   def current_user
       @current_user ||= User.find_by(id: session[:user_id])
   end
   
    #   current userが存在していれば、true
    # 否定演算子!を二回使ったもの。
   def logged_in?
      !!current_user
   end
    #   ログインが必要なページにアクセスしようとした際に、ページのURLを一旦保存しておき、
    # ログイン画面に遷移してログイン後に再び保存したURLにアクセスする場合にこのメソッドを使用する
   def store_location
       session[:forwarding_url] = request.url if request.get?
   end
end