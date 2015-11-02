class LikesController < ApplicationController
    
    def create
        @micropost = Micropost.find(params[:micropost_id])
        current_user.like(@micropost)
    end
    def destroy
        @micropost = Micropost.find(params[:micropost_id])
        current_user.unlike(@micropost)
    end 

end
