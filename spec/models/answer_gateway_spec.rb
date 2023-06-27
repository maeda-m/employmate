require 'rails_helper'

RSpec.describe AnswerGateway, type: :model do
  describe '#cast_overtime' do
    context '6か月のうち、1か月単体で100時間以上の時間外労働があったとき' do
      it '戻り値が true である' do
        overtimes = [100, 0, 0, 0, 0, 0]

        expect(described_class.new.cast_overtime(overtimes)).to eq true
      end
    end

    context '6か月のうち、2か月平均で80時間以上の時間外労働があったとき' do
      it '戻り値が true である' do
        overtimes = [0, 0, 80, 99, 0, 0]

        expect(described_class.new.cast_overtime(overtimes)).to eq true
      end
    end

    context '6か月のうち、3か月連続で45時間以上の時間外労働があったとき' do
      it '戻り値が true である' do
        overtimes = [0, 0, 0, 45, 60, 70]

        expect(described_class.new.cast_overtime(overtimes)).to eq true
      end
    end

    context '6か月のうち、1か月のみ45時間以上、99時間未満の時間外労働があったとき' do
      it '戻り値が false である' do
        overtimes = [0, 45, 0, 99, 0, 88]

        expect(described_class.new.cast_overtime(overtimes)).to eq false
      end
    end

    context '6か月のうち、2か月連続で45時間以上、80時間未満の時間外労働があったとき' do
      it '戻り値が false である' do
        overtimes = [60, 45, 0, 0, 75, 60]

        expect(described_class.new.cast_overtime(overtimes)).to eq false
      end
    end

    context '6か月のうち、連続しない3か月で45時間以上の時間外労働があったとき' do
      it '戻り値が false である' do
        overtimes = [45, 0, 45, 0, 45, 0]

        expect(described_class.new.cast_overtime(overtimes)).to eq false
      end
    end

    context '6か月のうち、45時間未満の時間外労働があったとき' do
      it '戻り値が false である' do
        overtimes = [20, 15, 30, 40, 44, 0]

        expect(described_class.new.cast_overtime(overtimes)).to eq false
      end
    end
  end
end
