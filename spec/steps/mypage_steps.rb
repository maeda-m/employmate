step '会員登録時にやることリストが退職日:dateとして作成されている' do |date|
  user = current_user
  user.profile.update!(unemployed_on: Date.parse(date))
  user.create_tasks
end

step 'やることリストのタスクをすべて完了している' do
  current_user.tasks.update(done: true)
end

step '失業認定日は初回:dateで週の型:week_type、:day_of_week曜日である' do |date, week_type, day_of_week|
  current_user.profile.update!(
    fixed_first_unemployment_certification_on: Date.parse(date),
    week_type_for_unemployment_certification: week_type,
    day_of_week_for_unemployment_certification: day_of_week
  )
end

step '離職理由コード:codeである' do |code|
  current_user.profile.update!(
    reason_code_for_loss_of_employment: code
  )
end

step '次のとおり、:groupの未完了のやることリストがある:' do |group, table|
  fields = table.rows.flatten

  section = find('h2', text: group).ancestor('section.todo')
  fields.each { |field| expect(section).to have_unchecked_field(field) }

  actual_fields_count = section.all('input[type="checkbox"]').count
  expect(actual_fields_count).to eq fields.count
end

step '次のとおり、完了分のやることリストがある:' do |table|
  fields = table.rows.flatten

  section = find('h2', text: '完了分').ancestor('section.done')
  fields.each { |field| expect(section).to have_checked_field(field, disabled: true) }

  actual_fields_count = section.all('input[type="checkbox"]').count
  expect(actual_fields_count).to eq fields.count
end
