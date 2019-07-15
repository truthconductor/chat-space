class UsersController < ApplicationController

  def index
    # 検索フォームのキーワードでユーザーを検索
    @users = User.where('name LIKE(?)', "%#{params[:keyword]}%")
                 .where().not(id: current_user.id)
                 .order('id ASC').limit(20)
    respond_to do |format|
      format.json { }
    end
  end

  def edit
  end

  def update
    if current_user.update(user_params)
      redirect_to controller: 'groups', action: 'index'
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email)
  end

end
