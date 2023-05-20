step '次のとおり、予定表がある:' do |table|
  all('table tr').each.with_index do |row, i|
    row.all('td').each.with_index do |cell, n|
      expect(cell.text).to include table.raw[i][n]
    end
  end
end
