require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  describe 'POST /sessions' do
    controller do
      def protect_id_token_forgery; end
    end

    let!(:google_client_session) { Session.create!(session_id: session.id.private_id, data: {}) }
    let!(:anonymous_user_session) { Session.create!(session_id: 'anonymous_session_id', data: {}) }
    let!(:registered_user) do
      user = FactoryBot.create(:user, :with_anonymous)
      user.register('registered_google_id')

      user
    end

    context '会員登録済みのGoogleIDでログインしたとき' do
      controller do
        def authenticated_google_id
          'registered_google_id'
        end
      end

      it 'ログイン処理はマイページにリダイレクトされる' do
        post :create, params: { state: anonymous_user_session.token }

        expect(google_client_session.reload.user_id).to eq registered_user.id
        expect(response).to redirect_to("/users/#{registered_user.id}")
        expect(flash[:notice]).to eq 'ログインしました。'
      end
    end

    context '会員未登録のGoogleIDでログインしたとき' do
      controller do
        def authenticated_google_id
          'unregistered_google_id'
        end
      end

      it 'ログイン処理はウェルカムページにリダイレクトされる' do
        post :create, params: { state: anonymous_user_session.token }

        expect(google_client_session.reload.user_id).to eq nil
        expect(response).to redirect_to('/')
        expect(flash[:notice]).to eq 'ログインできませんでした。'
      end
    end
  end
end
