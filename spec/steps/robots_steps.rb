step '環境変数:nameが未設定である' do |name|
  ENV[name] = nil
end

step '環境変数:nameに:valueを設定する' do |name, value|
  ENV[name] = value
end

step 'ブラウザで:visit_pathにアクセスする' do |visit_path|
  visit(visit_path)
end

step 'レスポンス形式が:content_typeである' do |content_type|
  assert page.response_headers['content-type'].include?(content_type)
end

step 'レスポンス本文に:contentとある' do |content|
  assert_text(content)
end

step 'レスポンス本文に:contentとない' do |content|
  assert_no_text(content)
end
