class Api::MessagesController < ApplicationController
  def index

    # 最新メッセージ以降で同じチャットグループのメッセージを取得
    @messages = Message.where("id > ?", chat_param[:last_message_id])
                  .where(group_id: chat_param[:group_id])

    # jsonで返す
    respond_to do |format|
      format.json { }
    end
  end

  private
  def chat_param
    params.permit(:last_message_id, :group_id)
  end

end