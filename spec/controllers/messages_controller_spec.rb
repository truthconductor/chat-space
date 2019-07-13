require 'rails_helper'

describe MessagesController, type: :controller do
  # letを利用してテスト中使用するインスタンスを定義(遅延評価)
  let(:group) { create(:group) }
  let(:user) { create(:user) }
  describe "Get #index" do
    context "is user login" do
      #example(it)の前に実行
      before do
        login_user user
        get :index, params: { group_id: group.id }
      end

      it "assigns @message" do
        #コントローラの@messageがMessageクラスの未保存レコードか？
        expect(assigns(:message)).to be_a_new(Message)
      end

      it "assigns @group" do
        expect(assigns(:group)).to eq group
      end

      it "render the :index template" do
        expect(response).to render_template :index
      end
    end

    context "is not user login" do
      before do
        get :index, params: { group_id: group.id }
      end

      it "redirect the new_user_session_path" do
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe "Post #create" do
    let(:params) { { group_id: group.id, user_id: user.id, message: attributes_for(:message) } }

    context "is user login" do
      #example(it)の前に実行
      before do
        login_user user
      end

      context "messge can save" do
        subject {
          post :create,
          params: params
        }

        it "count up message" do
          expect{ subject }.to change(Message, :count).by(1)
        end

        it "redirect the group_messages_path" do
          subject
          expect(response).to redirect_to(group_messages_path(group))
        end
      end

      context "message can not save" do
        let(:invalid_params) { { group_id: group.id, user_id: user.id, message: attributes_for(:message, body: nil, image: nil) } }

        subject {
          post :create,
          params: invalid_params
        }

        it "dose not count up message" do
          expect{ subject }.not_to change(Message, :count)
        end

        it "render the index flash alert" do
          subject
          expect(response).to render_template :index
        end
      end
    end

    context "is not user login" do
      subject {
        post :create,
        params: params
      }

      it "redirect the new_user_session_path" do
        subject
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end