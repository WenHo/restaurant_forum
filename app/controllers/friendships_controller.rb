class FriendshipsController < ApplicationController
	def create
  	@friendship = current_user.friendships.build(friend_id: params[:friend_id])

    if @friendship.save
      flash[:notice] = "Successfully friended"
      redirect_back(fallback_location: root_path)
    else
      # 驗證失敗時，Model 將錯誤訊息放在 errors 裡回傳
      # 使用 errors.full_messages 取出完成訊息集合(Array)，串接 to_sentence 將 Array 組合成 String
      flash[:alert] = @friendship.errors.full_messages.to_sentence
      redirect_back(fallback_location: root_path)
    end
  end
  def destroy
    @friendship = current_user.friendships.where(friend_id:params[:id]).first
    @friendship.destroy
    flash[:alert] = "friendship destroyed"
    redirect_back(fallback_location: root_path)
  end
end
