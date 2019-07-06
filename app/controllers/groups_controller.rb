class GroupsController < ApplicationController
  def new
    @group = Group.new
  end

  def create
    #groupとuser_idsで関連付いたuserを合わせて作成
    @group = Group.new(create_params)
    if @group.save
      redirect_to root_path, notice: 'グループを作成しました'
    else
      render :new
    end
  end

  def edit
  end

  def update
  end

  private

  #formで送られてきたパラメーターをストロングパラメータとして取得
  def create_params
    params.require(:group).permit(:name, { :user_ids => [] })
  end
end
