require 'rails_helper'

RSpec.describe '会員登録状況によってアクセス制御をする', type: :request do
  before do
    Session.destroy_all
  end

  context '会員登録済みユーザー（GoogleID連携済み）のとき' do
    before do
      get '/'
      current_session_store = Session.find_by(session_id: session.id.private_id)
      current_session_store.current_user = registered_user
    end

    let(:registered_user) { FactoryBot.create(:user, :with_registered) }

    it 'ウェルカムページはマイページにリダイレクトされる' do
      get '/'
      expect(response).to redirect_to("/users/#{registered_user.id}")
    end

    it '利用規約ページを表示できる' do
      get '/terms-of-service'
      expect(response).to have_http_status(:ok)
    end

    it 'プライバシーポリシーページを表示できる' do
      get '/privacy-policy'
      expect(response).to have_http_status(:ok)
    end

    it 'robots.txtを表示できる' do
      get '/robots.txt'
      expect(response).to have_http_status(:ok)
    end

    # ログイン処理はGoogleがPOSTするため、常に未ログイン状態になる
    # 会員登録処理はGoogleがPOSTするため、常に未ログイン状態になる
    # 退会処理は別テストで実施する

    it '初回分析調査ページはマイページにリダイレクトされる' do
      get '/surveys/1/profiles'
      expect(response).to redirect_to("/users/#{registered_user.id}")
    end

    it '初回分析調査の質問表示制御処理（次へ）はマイページにリダイレクトされる' do
      post '/surveys/1/questions/1/next'
      expect(response).to redirect_to("/users/#{registered_user.id}")
    end

    it '初回分析調査の質問表示制御処理（戻る）はマイページにリダイレクトされる' do
      post '/surveys/1/questions/2/back'
      expect(response).to redirect_to("/users/#{registered_user.id}")
    end

    it '初回分析調査回答処理はマイページにリダイレクトされる' do
      post '/surveys/1/answers'
      expect(response).to redirect_to("/users/#{registered_user.id}")
    end

    it '初回分析調査回答結果ページはマイページにリダイレクトされる' do
      get "/users/#{registered_user.id}/profile"
      expect(response).to redirect_to("/users/#{registered_user.id}")
    end

    # マイページは別テストで実施する
    # やることの完了処理は別テストで実施する
    # やること完了前にする調査ページは別テストで実施する
    # 離職票の受理調査回答処理は別テストで実施する
    # 雇用保険受給資格者証の交付調査回答処理は別テストで実施する
  end

  context '匿名ユーザー（初回分析調査回答済みかつ、会員登録未登録）のとき' do
    before do
      get '/'
      anonymous_user = FactoryBot.create(:user, :with_anonymous)
      current_session_store = Session.find_by(session_id: session.id.private_id)
      current_session_store.current_user = anonymous_user
    end

    it 'ウェルカムページを表示できる' do
      get '/'
      expect(response).to have_http_status(:ok)
    end

    it '利用規約ページを表示できる' do
      get '/terms-of-service'
      expect(response).to have_http_status(:ok)
    end

    it 'プライバシーポリシーページを表示できる' do
      get '/privacy-policy'
      expect(response).to have_http_status(:ok)
    end

    it 'robots.txtを表示できる' do
      get '/robots.txt'
      expect(response).to have_http_status(:ok)
    end

    # ログイン処理はGoogleがPOSTするため、常に未ログイン状態になる
    # 会員登録処理はGoogleがPOSTするため、常に未ログイン状態になる

    it '退会処理はウェルカムページにリダイレクトされる' do
      delete '/users/123'
      expect(response).to redirect_to('/')
    end

    # 初回分析調査ページは別テストで実施する
    # 初回分析調査の質問表示制御処理（次へ）は別テストで実施する
    # 初回分析調査の質問表示制御処理（戻る）は別テストで実施する
    # 初回分析調査回答処理は別テストで実施する
    # 初回分析調査回答結果ページは別テストで実施する

    it 'マイページはウェルカムページにリダイレクトされる' do
      get '/users/123'
      expect(response).to redirect_to('/')
    end

    it 'やることの完了処理はウェルカムページにリダイレクトされる' do
      put '/tasks/123'
      expect(response).to redirect_to('/')
    end

    it 'やること完了前にする調査ページはウェルカムページにリダイレクトされる' do
      get '/surveys/123/tasks'
      expect(response).to redirect_to('/')
    end

    it '離職票の受理調査回答処理はウェルカムページにリダイレクトされる' do
      post '/surveys/123/approvals'
      expect(response).to redirect_to('/')
    end

    it '雇用保険受給資格者証の交付調査回答処理はウェルカムページにリダイレクトされる' do
      post '/surveys/123/issuances'
      expect(response).to redirect_to('/')
    end
  end

  context '上記のユーザーに当てはまらないすべてのユーザー' do
    it 'ウェルカムページを表示できる' do
      get '/'
      expect(response).to have_http_status(:ok)
    end

    it '利用規約ページを表示できる' do
      get '/terms-of-service'
      expect(response).to have_http_status(:ok)
    end

    it 'プライバシーポリシーページを表示できる' do
      get '/privacy-policy'
      expect(response).to have_http_status(:ok)
    end

    it 'robots.txtを表示できる' do
      get '/robots.txt'
      expect(response).to have_http_status(:ok)
    end

    # ログイン処理は別テストで実施する
    # 会員登録処理は別テストで実施する

    it '退会処理はウェルカムページにリダイレクトされる' do
      delete '/users/123'
      expect(response).to redirect_to('/')
    end

    # 初回分析調査ページは別テストで実施する
    # 初回分析調査の質問表示制御処理（次へ）は別テストで実施する
    # 初回分析調査の質問表示制御処理（戻る）は別テストで実施する
    # 初回分析調査回答処理は別テストで実施する
    # 初回分析調査回答結果ページは別テストで実施する

    it 'マイページはウェルカムページにリダイレクトされる' do
      get '/users/123'
      expect(response).to redirect_to('/')
    end

    it 'やることの完了処理はウェルカムページにリダイレクトされる' do
      put '/tasks/123'
      expect(response).to redirect_to('/')
    end

    it 'やること完了前にする調査ページはウェルカムページにリダイレクトされる' do
      get '/surveys/123/tasks'
      expect(response).to redirect_to('/')
    end

    it '離職票の受理調査回答処理はウェルカムページにリダイレクトされる' do
      post '/surveys/123/approvals'
      expect(response).to redirect_to('/')
    end

    it '雇用保険受給資格者証の交付調査回答処理はウェルカムページにリダイレクトされる' do
      post '/surveys/123/issuances'
      expect(response).to redirect_to('/')
    end
  end
end
