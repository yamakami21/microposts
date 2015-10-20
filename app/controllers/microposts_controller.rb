class MicropostsController < ApplicationController
    # ApplicationControllerのlogged_in_userがよばれる。
    before_action :logged_in_user, only: [:create]
    
    def create
        @micropost = current_user.microposts.build(micropost_params)
        if @micropost.save
            flash[:success] = "Micropost created"
            # root_urlが何なのか自分で確かめる。
            redirect_to root_url
        else
            render 'static_pages/home'
        end
    end
    
    private 
    def micropost_params
        # フォームから受け取ったパラメータのparams[:micropost]のうち、
        # params[:micropost][:content]のみデータの作成に使用する
        params.require(:micropost).permit(:content)
    end
end
