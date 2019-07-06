class GroupsController < ApplicationController
  before_action :set_group, only: [:edit, :update]

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
  end

  def update
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

  #:idでアクセスされた該当グループを表示
  def set_group
    @group = Group.find(params[:id])
  end
end
