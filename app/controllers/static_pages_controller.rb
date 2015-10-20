class StaticPagesController < ApplicationController
  def home
    # ログインしている場合は、新しいMicropostクラスのインスタンスをuser_idにひも付けた状態で初期化する。
    # current_user.microposts.buildは、Micropost.new(user_id: current_user.id)と同じ
    @micropost = current_user.microposts.build if logged_in?
  end
end
