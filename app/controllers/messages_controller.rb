class MessagesController < ApplicationController
  def index
    @group = Group.find(params[:group_id])
    @message = Message.new()
  end

  def create
    @message = Message.new(message_param)
    # バリデーション
    unless @message.valid?
      @group = Group.find(params[:group_id])
      flash.now[:alert] = "メッセージを入力してください。"
      render :index
      return
    end

    #メッセージ保存（送信）
    if @message.save
      redirect_to controller: "messages", action:"index", id: params[:id], notice: "メッセージを送信しました"
    else
      @group = Group.find(params[:group_id])
      flash.now[:alert] = "メッセージを送信できませんでした。"
      render :index
    end
  end

  private

  def message_param
    params.require(:message).permit(:body, :image).merge(group_id: params[:group_id], user_id: current_user.id)
  end
end
