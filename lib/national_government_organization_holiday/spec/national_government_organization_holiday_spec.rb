# frozen_string_literal: true

RSpec.describe NationalGovernmentOrganizationHoliday do
  describe 'Date#plus_with_duration' do
    context '日曜日および土曜日を起算日とした場合' do
      it '日曜日および土曜日は祝日でない' do
        saturday = Date.new(2023, 4, 1)
        expect(saturday.saturday?).to eq true
        expect(saturday.national_holiday?).to eq false

        sunday = Date.new(2023, 4, 2)
        expect(sunday.sunday?).to eq true
        expect(sunday.national_holiday?).to eq false
      end

      it '1開庁日を加算すると平日の月曜日になる' do
        expected_value = Date.new(2023, 4, 3)
        expect(Date.new(2023, 4, 1) + 1.national_gov_org_weekday).to eq expected_value
        expect(Date.new(2023, 4, 2) + 1.national_gov_org_weekday).to eq expected_value

        expect(expected_value.monday?).to eq true
        expect(expected_value.national_holiday?).to eq false
      end

      it '2開庁日を加算すると平日の火曜日になる' do
        expected_value = Date.new(2023, 4, 4)
        expect(Date.new(2023, 4, 1) + 2.national_gov_org_weekdays).to eq expected_value
        expect(Date.new(2023, 4, 2) + 2.national_gov_org_weekdays).to eq expected_value

        expect(expected_value.tuesday?).to eq true
        expect(expected_value.national_holiday?).to eq false
      end
    end

    context '平日の12/29 - 1/3までを起算日とした場合' do
      it '平日の1/1 - 1/3までの起算日に1開庁日を加算すると 1/4 になる' do
        expected_value = Date.new(2019, 1, 4)
        expect(Date.new(2019, 1, 1).tuesday?).to eq true
        expect(Date.new(2019, 1, 1) + 1.national_gov_org_weekday).to eq expected_value
        expect(Date.new(2019, 1, 2) + 1.national_gov_org_weekday).to eq expected_value
        expect(Date.new(2019, 1, 3) + 1.national_gov_org_weekday).to eq expected_value
      end

      it '平日の12/29 - 12/31までの起算日に1開庁日を加算すると翌年の 1/4 になる' do
        expected_value = Date.new(2022, 1, 4)
        expect(Date.new(2021, 12, 29).wednesday?).to eq true
        expect(Date.new(2021, 12, 29) + 1.national_gov_org_weekday).to eq expected_value
        expect(Date.new(2021, 12, 30) + 1.national_gov_org_weekday).to eq expected_value
        expect(Date.new(2021, 12, 31) + 1.national_gov_org_weekday).to eq expected_value
      end

      it '平日の12/28に1開庁日を加算すると翌年の 1/4 になる' do
        expected_value = Date.new(2016, 1, 4)
        expect(Date.new(2015, 12, 28).monday?).to eq true
        expect(Date.new(2015, 12, 28) + 1.national_gov_org_weekday).to eq expected_value
      end
    end

    context '国民の祝日に関する法律に規定する休日を起算日とした場合' do
      it '黄金週間（2019/4/27 - 5/6）は10連休である' do
        expect(Date.new(2019, 4, 26).friday?).to eq true
        expect(Date.new(2019, 4, 26).national_holiday?).to eq false

        expect(Date.new(2019, 4, 27).on_weekend?).to eq true
        expect(Date.new(2019, 4, 28).on_weekend?).to eq true
        expect(Date.new(2019, 4, 29).national_holiday?).to eq true
        expect(Date.new(2019, 4, 30).national_holiday?).to eq true
        expect(Date.new(2019, 5, 1).national_holiday?).to eq true
        expect(Date.new(2019, 5, 2).national_holiday?).to eq true
        expect(Date.new(2019, 5, 3).national_holiday?).to eq true
        expect(Date.new(2019, 5, 4).on_weekend?).to eq true
        expect(Date.new(2019, 5, 5).on_weekend?).to eq true
        expect(Date.new(2019, 5, 6).national_holiday?).to eq true

        expect(Date.new(2019, 5, 7).tuesday?).to eq true
        expect(Date.new(2019, 5, 7).national_holiday?).to eq false
      end

      it '黄金週間直前の平日に1開庁日を加算すると黄金週間明けの平日になる' do
        expect(Date.new(2019, 4, 26) + 1.national_gov_org_weekday).to eq Date.new(2019, 5, 7)
      end

      it '黄金週間の祝日に1開庁日を加算すると黄金週間明けの平日になる' do
        expect(Date.new(2019, 4, 29) + 1.national_gov_org_weekday).to eq Date.new(2019, 5, 7)
      end

      it '黄金週間の国民の休日に1開庁日を加算すると黄金週間明けの平日になる' do
        expect(Date.new(2019, 4, 30) + 1.national_gov_org_weekday).to eq Date.new(2019, 5, 7)
      end

      it '3連休前（土日祝）の金曜日に1開庁日を加算すると3連休明けの平日になる' do
        expected_value = Date.new(2023, 1, 10)
        expect(expected_value.national_holiday?).to eq false
        expect(Date.new(2023, 1, 6) + 1.national_gov_org_weekday).to eq expected_value

        expect(Date.new(2023, 1, 6).friday?).to eq true
        expect(Date.new(2023, 1, 7).on_weekend?).to eq true
        expect(Date.new(2023, 1, 8).on_weekend?).to eq true
        expect(Date.new(2023, 1, 9).national_holiday?).to eq true
      end

      it '隔日の祝日前の平日に2開庁日を加算すると祝日明けの平日になる' do
        expected_value = Date.new(1983, 5, 6)
        expect(expected_value.national_holiday?).to eq false
        expect(Date.new(1983, 5, 2) + 2.national_gov_org_weekdays).to eq expected_value

        expect(Date.new(1983, 5, 2).monday?).to eq true
        expect(Date.new(1983, 5, 3).national_holiday?).to eq true
        expect(Date.new(1983, 5, 4).national_holiday?).to eq false
        expect(Date.new(1983, 5, 5).national_holiday?).to eq true
      end
    end
  end

  describe 'Duration#initialize' do
    context '引数が整数以外のとき' do
      it '整数以外は指定できない' do
        expect { NationalGovernmentOrganizationHoliday::Duration.new(nil) }.to raise_error(TypeError)
        expect { NationalGovernmentOrganizationHoliday::Duration.new('5') }.to raise_error(TypeError)
        expect { NationalGovernmentOrganizationHoliday::Duration.new(5.0) }.to raise_error(TypeError)

        expect { nil.national_gov_org_weekdays }.to raise_error(NoMethodError)
        expect { '5'.national_gov_org_weekdays }.to raise_error(NoMethodError)
        expect { 5.0.national_gov_org_weekdays }.to raise_error(NoMethodError)
      end
    end

    context '引数が整数であるが限界値を超えるとき' do
      it '上限の7開庁日を超える整数は指定できない' do
        expect(7.national_gov_org_weekdays).to be_truthy
        expect { 8.national_gov_org_weekdays }.to raise_error(ArgumentError)
      end

      it '下限の1開庁日を下回る整数は指定できない' do
        expect(1.national_gov_org_weekdays).to be_truthy
        expect { 0.national_gov_org_weekdays }.to raise_error(ArgumentError)
      end
    end
  end
end
