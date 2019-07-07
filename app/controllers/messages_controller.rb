class MessagesController < ApplicationController
  def index
    @group = Group.find(params[:group_id])
    @message = Message.new()
  end

  def create
    @message = Message.new(message_param)
    unless @message.valid?
      @group = Group.find(params[:group_id])
      flash.now[:alert] = "メッセージを入力してください。"
      render :index
      return
    end
  end

  private

  def message_param
    params.require(:message).permit(:body, :image)
  end
end
