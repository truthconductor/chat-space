class MessagesController < ApplicationController
  def index
    @group = Group.find(params[:group_id])
    @message = Message.new()
  end

  def create
    
  end
end
