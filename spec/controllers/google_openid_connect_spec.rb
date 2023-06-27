require 'rails_helper'

class ExamplesController < ApplicationController
  include GoogleOpenIdConnect

  def create
    authenticated_google_id

    render plain: 'ok'
  end
end

RSpec.describe ExamplesController, type: :controller do # rubocop:disable RSpec/FilePath
  describe '#authenticated_google_id' do
    controller do
      def protect_id_token_forgery; end
      def set_authenticated_session; end
    end

    it '不正な ID token は 422 エラーになる' do
      expect { post :create, params: { credential: 'example' } }.to raise_error(ActionController::InvalidAuthenticityToken)
    end
  end

  describe '#protect_id_token_forgery' do
    controller do
      def authenticated_google_id; end
      def set_authenticated_session; end
    end

    it '不正な Double Submit Cookie は 422 エラーになる' do
      expect { post :create, params: { g_csrf_token: 'example' } }.to raise_error(ActionController::InvalidAuthenticityToken)
    end
  end

  describe '#set_authenticated_session' do
    controller do
      def authenticated_google_id; end
      def protect_id_token_forgery; end
    end

    it '7日間まではセッション状態を維持でき、認証に使用したレコードは削除される' do
      anonymous_user_session = Session.create!(created_at: (7.days.ago + 1.hour), session_id: 'anonymous_session_id', data: {})

      expect { post :create, params: { state: anonymous_user_session.token } }.to change(Session, :count).by(-1)
      expect(Session.exists?(session_id: 'anonymous_session_id')).to eq false
    end

    it '7日間以降は不正なセッションとして判断され 422 エラーになる' do
      anonymous_user_session = Session.create!(created_at: 8.days.ago, session_id: 'anonymous_session_id', data: {})

      expect { post :create, params: { state: anonymous_user_session.token } }.to raise_error(ActionController::InvalidAuthenticityToken)
    end
  end
end
