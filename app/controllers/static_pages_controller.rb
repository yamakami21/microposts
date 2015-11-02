class StaticPagesController < ApplicationController
  def home
    # current_user.microposts.buildは、Micropost.new(user_id: current_user.id)と同じ
      if logged_in?
        @micropost = current_user.microposts.build if logged_in?
        
        # feed_itemsで現在のユーザーのフォローしているユーザーを取得し、
        # order(created_at: :desc)投稿日で並び替え
        @feed_items = current_user.feed_items.includes(:user).page(params[:page]).per(10).order(created_at: :desc)

      end 
  end
end
