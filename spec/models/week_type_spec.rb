require 'rails_helper'

RSpec.describe WeekType, type: :model do
  describe '.beginning_of_year' do
    context '引数で与えられた年の1月1日の週が1型のとき' do
      it '戻り値が 1 である' do
        expect(described_class.beginning_of_year(2001)).to eq 1
        expect(described_class.beginning_of_year(2005)).to eq 1
        expect(described_class.beginning_of_year(2023)).to eq 1
      end
    end

    context '引数で与えられた年の1月1日の週が2型のとき' do
      it '戻り値が 2 である' do
        expect(described_class.beginning_of_year(2006)).to eq 2
        expect(described_class.beginning_of_year(2011)).to eq 2
        expect(described_class.beginning_of_year(2029)).to eq 2
      end
    end

    context '引数で与えられた年の1月1日の週が3型のとき' do
      it '戻り値が 3 である' do
        expect(described_class.beginning_of_year(2012)).to eq 3
        expect(described_class.beginning_of_year(2016)).to eq 3
        expect(described_class.beginning_of_year(2034)).to eq 3
      end
    end

    context '引数で与えられた年の1月1日の週が4型のとき' do
      it '戻り値が 4 である' do
        expect(described_class.beginning_of_year(2000)).to eq 4
        expect(described_class.beginning_of_year(2017)).to eq 4
        expect(described_class.beginning_of_year(2022)).to eq 4
      end
    end

    context '引数で与えられた年が雇用保険法公布前のとき' do
      it 'ArgumentError が発生する' do
        expect { described_class.beginning_of_year(1973) }.to raise_error(ArgumentError)
      end
    end
  end

  describe '.from_date' do
    context '引数で与えられた日付が属する年の1月1日の型が1のとき' do
      context '引数で与えられた日付が1型のとき' do
        it '戻り値が 1 である（日曜日）' do
          expect(described_class.from_date(Date.new(2023, 1, 1))).to eq 1
        end

        it '戻り値が 1 である（日曜日以外）' do
          expect(described_class.from_date(Date.new(2023, 1, 2))).to eq 1
        end
      end

      context '引数で与えられた日付が2型のとき' do
        it '戻り値が 2 である（日曜日）' do
          expect(described_class.from_date(Date.new(2023, 2, 5))).to eq 2
        end

        it '戻り値が 2 である（日曜日以外）' do
          expect(described_class.from_date(Date.new(2023, 2, 10))).to eq 2
        end
      end

      context '引数で与えられた日付が3型のとき' do
        it '戻り値が 3 である（日曜日）' do
          expect(described_class.from_date(Date.new(2023, 3, 12))).to eq 3
        end

        it '戻り値が 3 である（日曜日以外）' do
          expect(described_class.from_date(Date.new(2023, 3, 14))).to eq 3
        end
      end

      context '引数で与えられた日付が4型のとき' do
        it '戻り値が 4 である（日曜日）' do
          expect(described_class.from_date(Date.new(2023, 4, 16))).to eq 4
        end

        it '戻り値が 4 である（日曜日以外）' do
          expect(described_class.from_date(Date.new(2023, 4, 21))).to eq 4
        end
      end
    end

    context '引数で与えられた日付が属する年の1月1日の型が1でないとき' do
      context '引数で与えられた日付が1型のとき' do
        it '戻り値が 1 である（日曜日）' do
          expect(described_class.from_date(Date.new(2022, 1, 2))).to eq 1
        end

        it '戻り値が 1 である（日曜日以外）' do
          expect(described_class.from_date(Date.new(2022, 1, 7))).to eq 1
        end
      end

      context '引数で与えられた日付が2型のとき' do
        it '戻り値が 2 である（日曜日）' do
          expect(described_class.from_date(Date.new(2022, 12, 11))).to eq 2
        end

        it '戻り値が 2 である（日曜日以外）' do
          expect(described_class.from_date(Date.new(2022, 12, 13))).to eq 2
        end
      end

      context '引数で与えられた日付が3型のとき' do
        it '戻り値が 3 である（日曜日）' do
          expect(described_class.from_date(Date.new(2022, 11, 20))).to eq 3
        end

        it '戻り値が 3 である（日曜日以外）' do
          expect(described_class.from_date(Date.new(2022, 11, 23))).to eq 3
        end
      end

      context '引数で与えられた日付が4型のとき' do
        it '戻り値が 4 である（日曜日）' do
          expect(described_class.from_date(Date.new(2022, 10, 30))).to eq 4
        end

        it '戻り値が 4 である（日曜日以外）' do
          expect(described_class.from_date(Date.new(2022, 10, 31))).to eq 4
        end
      end
    end
  end
end
