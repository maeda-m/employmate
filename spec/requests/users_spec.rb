require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'DELETE /users' do
    context '別のユーザーの「退会する」を試みたとき' do
      it '404エラーになる' do
        get '/'
        current_session_user = FactoryBot.create(:user, :with_registered)
        current_session_store = Session.find_by(session_id: session.id.private_id)
        current_session_store.current_user = current_session_user

        other_user = FactoryBot.create(:user, :with_registered)
        expect { delete "/users/#{other_user.id}" }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end
