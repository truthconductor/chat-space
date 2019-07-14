class MessagesController < ApplicationController
  before_action :set_group, only: [:index, :create]
  def index
    @message = Message.new
    @messages = @group.messages.includes(:user)
  end

  def create
    @message = @group.messages.new(message_param)
    # バリデーション
    unless @message.valid?
      respond_to do |format|
        format.html {
          flash.now[:alert] = "メッセージを入力してください"
          render :index
        }
        format.json { }
      end
      return
    end

    #メッセージ保存（送信）
    if @message.save
      respond_to do |format|
        format.html { redirect_to group_messages_path(@group), notice: "メッセージを送信しました"}
        format.json { }
      end
    else
      @messages = @group.messages.includes(:user)
      respond_to do |format|
        format.html {
          flash.now[:alert] = "メッセージ送信エラー"
          render :index
        }
        format.json { }
      end
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
