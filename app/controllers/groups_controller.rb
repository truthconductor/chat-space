class GroupsController < ApplicationController
  def new
    @group = Group.new
  end

  def create
    #groupとuser_idsで関連付いたuserを合わせて作成
    @group = Group.new(group_params)
    if @group.save
      redirect_to root_path, notice: 'グループを作成しました'
    else
      render :new
    end
  end

  def edit
    @group = Group.find(params[:id])
  end

  def update
    @group = Group.find(params[:id])
    if @group.update(group_params)
      redirect_to root_path, notice: 'グループを編集しました'
    else
      render :edit
    end
  end

  private

  #formで送られてきたパラメーターをストロングパラメータとして取得
  def group_params
    params.require(:group).permit(:name, { :user_ids => [] })
  end
end
