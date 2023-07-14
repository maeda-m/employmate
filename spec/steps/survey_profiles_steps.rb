step '次のとおり、タイムラインがある:' do |table|
  expected_rows = table.rows

  within('ul.timeline') do
    expected_rows.each do |cells|
      expect(page).to have_text(cells.first)
      expect(page).to have_text(cells.last)
    end
  end
end
