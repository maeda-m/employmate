step '未ログインである' do
  # TODO
end

step 'ブラウザで:visit_pathにアクセスする' do |visit_path|
  visit(visit_path)
end

step 'ページ本文に:contentとある' do |content|
  within('main') do
    expect(page).to have_text(content)
  end
end

step 'ページ本文に:contentとない' do |content|
  within('main') do
    expect(page).to have_no_text(content)
  end
end

step 'ページヘッダーに:contentとある' do |content|
  within('header') do
    expect(page).to have_text(content)
  end
end

step 'ページフッターに:contentとある' do |content|
  within('footer') do
    expect(page).to have_text(content)
  end
end

step 'ページフッターにリンク:nameとある' do |name|
  within('footer') do
    expect(page).to have_link(name)
  end
end

step 'ボタン:nameがある' do |name|
  within('main') do
    case name
    when 'Googleでログイン'
      expect(page).to have_selector('iframe[title="[Googleでログイン]ボタン"]')
    else
      expect(page).to have_selector(:link_or_button, name)
    end
  end
end

step 'ボタン:nameがない' do |name|
  within('main') do
    expect(page).to have_no_selector(:link_or_button, name)
  end
end

step 'ボタン:nameをクリックする' do |name|
  click_on(name)
end

step 'フィールド:labelに:valueと入力する' do |label, value|
  fill_in(label, with: value)
end
