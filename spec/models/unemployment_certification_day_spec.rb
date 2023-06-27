require 'rails_helper'

RSpec.describe UnemploymentCertificationDay, type: :model do
  describe '.to_date' do
    describe '暫定の失業認定日' do
      context '起算日の7開庁日後が月曜日のとき' do
        it '戻り値が月曜日である' do
          beginning_day = Date.new(2023, 3, 15)
          expected_value = described_class.new(beginning_day:).to_date

          expect((beginning_day + 7.national_gov_org_weekdays).monday?).to eq true
          expect(expected_value.monday?).to eq true
          expect(expected_value).to eq Date.new(2023, 3, 27)
        end
      end

      context '起算日の7開庁日後が火曜日のとき' do
        it '戻り値が月曜日である' do
          beginning_day = Date.new(2023, 3, 16)
          expected_value = described_class.new(beginning_day:).to_date

          expect((beginning_day + 7.national_gov_org_weekdays).tuesday?).to eq true
          expect(expected_value.monday?).to eq true
          expect(expected_value).to eq Date.new(2023, 3, 27)
        end
      end

      context '起算日の7開庁日後が水曜日のとき' do
        it '戻り値が月曜日である' do
          beginning_day = Date.new(2023, 3, 17)
          expected_value = described_class.new(beginning_day:).to_date

          expect((beginning_day + 7.national_gov_org_weekdays).wednesday?).to eq true
          expect(expected_value.monday?).to eq true
          expect(expected_value).to eq Date.new(2023, 3, 27)
        end
      end

      context '起算日の7開庁日後が木曜日のとき' do
        it '戻り値が月曜日である' do
          beginning_day = Date.new(2023, 3, 20)
          expected_value = described_class.new(beginning_day:).to_date

          expect((beginning_day + 7.national_gov_org_weekdays).thursday?).to eq true
          expect(expected_value.monday?).to eq true
          expect(expected_value).to eq Date.new(2023, 3, 27)
        end
      end

      context '起算日の7開庁日後が金曜日のとき' do
        it '戻り値が月曜日である' do
          beginning_day = Date.new(2023, 3, 22)
          expected_value = described_class.new(beginning_day:).to_date

          expect((beginning_day + 7.national_gov_org_weekdays).friday?).to eq true
          expect(expected_value.monday?).to eq true
          expect(expected_value).to eq Date.new(2023, 3, 27)
        end
      end
    end

    describe '確定の失業認定日' do
      context '起算日の28日後が開庁日のとき' do
        it '戻り値が28日以内で最も未来の平日でかつ、指定した週の型と曜日が同じである' do
          week_type = 1
          day_of_week = 2
          beginning_day = Date.new(2023, 3, 28)
          expected_value = described_class.new(
            week_type:, day_of_week:, beginning_day:
          ).to_date

          expect(expected_value).to eq Date.new(2023, 4, 25)
          expect(WeekType.from_date(expected_value)).to eq week_type
          expect(expected_value.wday).to eq day_of_week
        end
      end

      context '起算日の28日後が閉庁日のとき' do
        it '戻り値が28日以内で最も未来の開庁日でかつ、指定した週の型の開庁日に繰り上げされる' do
          week_type = 2
          day_of_week = 5
          beginning_day = Date.new(2023, 4, 7)
          expected_value = described_class.new(
            week_type:, day_of_week:, beginning_day:
          ).to_date

          expect(expected_value).to eq Date.new(2023, 5, 2)
          expect(WeekType.from_date(expected_value)).to eq week_type
          expect(expected_value.wday).not_to eq day_of_week
        end

        it '戻り値が28日以内で最も未来の開庁日でかつ、指定した週の型のよりも前の週の開庁日に繰り上げされる' do
          week_type = 4
          day_of_week = 1
          beginning_day = Date.new(2022, 2, 21)
          expected_value = described_class.new(
            week_type:, day_of_week:, beginning_day:
          ).to_date

          expect(expected_value).to eq Date.new(2022, 3, 18)
          expect(WeekType.from_date(expected_value)).not_to eq week_type
          expect(expected_value.wday).not_to eq day_of_week
        end
      end
    end
  end
end
