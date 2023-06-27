step '環境変数:nameが未設定である' do |name|
  ENV[name] = nil
end

step '環境変数:nameに:valueを設定する' do |name, value|
  ENV[name] = value
end

step 'レスポンス形式が:content_typeである' do |content_type|
  expect(page.response_headers['content-type']).to include(content_type)
end

step 'レスポンス本文に:contentとある' do |content|
  expect(page).to have_text(content)
end

step 'レスポンス本文に:contentとない' do |content|
  expect(page).to have_no_text(content)
end
