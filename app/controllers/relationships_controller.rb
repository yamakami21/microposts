class RelationshipsController < ApplicationController
    before_action :logged_in_user
    
    def create
        # フォローするユーザのIDをパラメータとして受け取り、
        # 見つかったユーザを引数としてUserもでるのfollowを実行する。
        @user = User.find(params[:followed_id])
        current_user.follow(@user)
    end
    
    # 現在のユーザーのfollowing_relationshipsを検索して他のユーザーをフォローしている場合は、
    # そのユーザーを引数としてUserのunfollowメソッドを実行する。
    def destroy
        @user = current_user.following_relationships.find(params[:id]).followed
        current_user.unfollow(@user)
    end
end
