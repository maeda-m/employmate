step '未ログインである' do
  expect(session_private_id_from_cookie_value).to eq nil
end

step 'ユーザー:nameでログインする' do |name|
  visit('/')
  user = case name
         when '初回分析回答直後'
           FactoryBot.create(:user, :with_anonymous)
         when 'GoogleID連携済み', '初回分析で給付制限ありと推定'
           FactoryBot.create(:user, :with_registered)
         when '初回分析で特定理由離職者と推定'
           FactoryBot.create(:user, :with_registered, :with_special_reason_profile)
         else
           raise NotImplementedError, name
         end

  current_session_store.signin_by(user)
end

step 'ブラウザで:visit_pathにアクセスする' do |visit_path|
  case visit_path
  when '/users/:user_id/profile'
    visit(visit_path.sub(':user_id', current_user.id.to_s))
  else
    visit(visit_path)
  end
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

step 'トースト:contentがある' do |content|
  within(find('div.swal2-container')) do
    expect(page).to have_text(content)
  end
end

step 'ページヘッダーに:contentとある' do |content|
  within('body > header') do
    expect(page).to have_text(content)
  end
end

step 'ページヘッダーに:contentとない' do |content|
  within('body > header') do
    expect(page).to have_no_text(content)
  end
end

step 'ページヘッダーに画像:altとある' do |alt|
  within('body > header') do
    expect(page).to have_selector("img[alt='#{alt}']")
  end
end

step 'ページフッターに:contentとある' do |content|
  within('footer') do
    expect(page).to have_text(content)
  end
end

step 'ページフッターにリンク:nameとある' do |name|
  within('footer') do
    expect(page).to have_selector(:link_or_button, name)
  end
end

step 'ページフッターにリンク:nameがない' do |name|
  within('footer') do
    expect(page).to have_no_selector(:link_or_button, name)
  end
end

step 'ボタン:nameがある' do |name|
  within('main') do
    case name
    when 'Googleでログイン', 'Googleで登録'
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

step '(ボタン)(リンク):nameをクリックする' do |name|
  click_on(name)
end

step 'チェックボックス:nameをクリックする' do |name|
  check(name)
end

step 'リンク:nameをクリックした後、確認ダイアログの内容に:actionする' do |name, action|
  raise NotImplementedError, action unless action == '同意'

  accept_confirm do
    click_on(name)
  end
end

step 'フィールド:labelに:valueと入力する' do |label, value|
  fill_in(label, with: value)
end

step '単一選択ボタン:labelを選ぶ' do |label|
  choose(label)
end

step 'セレクトボックス:labelの:optionを選ぶ' do |label, option|
  select(option, from: label)
end

step 'セレクトボックス「年選択」の:optionを選ぶ' do |option|
  find('select#date_year').select(option)
end

step 'セレクトボックス「月選択」の:optionを選ぶ' do |option|
  find('select#date_month').select(option)
end

step '次のとおり、表がある:' do |table|
  expected_rows = table.rows

  rows = all('table tbody tr')
  rows.each.with_index do |row, i|
    expected_cells = expected_rows[i]

    cells = row.all('td')
    cells.each.with_index do |cell, n|
      expect(cell.text).to include expected_cells[n]
    end

    expect(cells.count).to eq expected_cells.count
  end
  expect(rows.count).to eq expected_rows.count

  expected_headers = table.headers

  headers = find('table thead tr').all('th')
  headers.each.with_index do |header, m|
    expect(header.text).to include expected_headers[m]
  end
  expect(headers.count).to eq expected_headers.count
end

step 'スクリーンショットをとる' do
  page.save_screenshot
end
