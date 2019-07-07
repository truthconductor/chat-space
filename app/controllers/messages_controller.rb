class MessagesController < ApplicationController
  before_action :set_group, only: [:index, :create]
  def index
    @message = Message.new
  end

  def create
    @message = @group.messages.new(message_param)
    # バリデーション
    unless @message.valid?
      flash.now[:alert] = "メッセージを入力してください。"
      render :index
      return
    end

    #メッセージ保存（送信）
    if @message.save
      redirect_to group_messages_path(@group), notice: "メッセージを送信しました"
    else
      flash.now[:alert] = "メッセージを送信できませんでした。"
      render :index
    end
  end

  private

  def set_group
    @group = Group.find(params[:group_id])
  end

  def message_param
    params.require(:message).permit(:body, :image).merge(user_id: current_user.id)
  end
end
