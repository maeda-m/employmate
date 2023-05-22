step '会員登録時にやることリストが作成されている' do
  current_user.create_tasks
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
