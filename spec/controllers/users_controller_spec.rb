require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'POST /users' do
    controller do
      def protect_id_token_forgery; end
    end

    let!(:google_client_session) { Session.create!(session_id: session.id.private_id, data: {}) }
    let!(:anonymous_user_session) { Session.create!(session_id: 'anonymous_session_id', user_id: anonymous_user.id, data: {}) }
    let!(:anonymous_user) { FactoryBot.create(:user, :with_anonymous) }
    let!(:registered_user) do
      user = FactoryBot.create(:user, :with_anonymous)
      user.register('registered_google_id')

      user
    end

    context '会員登録済みのGoogleIDで会員登録したとき' do
      controller do
        def authenticated_google_id
          'registered_google_id'
        end
      end

      it '会員登録処理はマイページにリダイレクトされる' do
        post :create, params: { state: anonymous_user_session.token }

        expect(google_client_session.reload.user_id).to eq registered_user.id
        expect(response).to redirect_to("/users/#{registered_user.id}")
        expect(flash[:notice]).to eq 'ログインしました。'
      end
    end

    context '会員未登録のGoogleIDで会員登録したとき' do
      controller do
        def authenticated_google_id
          'unregistered_google_id'
        end
      end

      it '会員登録処理はマイページにリダイレクトされる' do
        expect { post :create, params: { state: anonymous_user_session.token } }.to(change { anonymous_user.reload.registered? }.from(false).to(true))

        expect(google_client_session.reload.user_id).to eq anonymous_user.id
        expect(response).to redirect_to("/users/#{anonymous_user.id}")
        expect(flash[:notice]).to eq '会員登録しました。'
      end
    end
  end
end
