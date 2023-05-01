require 'rails_helper'

RSpec.describe Profile, type: :model do
  describe '#answered_profile_survey!' do
    context '受給期間延長を推奨する場合' do
      it '#recommended_to_extension_of_benefit_receivable_period? が true である'
    end

    context '受給期間延長を推奨しない場合' do
      it '#recommended_to_extension_of_benefit_receivable_period? が false である'
    end

    context '公共職業訓練を推奨する場合' do
      it '#recommended_to_public_vocational_training? が true である'
    end

    context '公共職業訓練を推奨しない場合' do
      it '#recommended_to_public_vocational_training? が false である'
    end

    describe '特定受給資格者に該当する場合' do
      context '6か月のうち、1か月単体で100時間以上の時間外労働があったとき' do
        it '#unemployed_with_special_eligible? が true である'
      end

      context '6か月のうち、2か月平均で80時間以上の時間外労働があったとき' do
        it '#unemployed_with_special_eligible? が true である'
      end

      context '6か月のうち、3か月連続で45時間以上の時間外労働があったとき' do
        it '#unemployed_with_special_eligible? が true である'
      end
    end

    describe '特定受給資格者に該当しない場合' do
      context '6か月のうち、1か月のみ時間外労働があり、それは99時間であったとき' do
        it '#unemployed_with_special_eligible? が false である'
      end

      context '6か月のうち、2か月連続で45時間以上、80時間未満の時間外労働があったとき' do
        it '#unemployed_with_special_eligible? が false である'
      end

      context '6か月のうち、連続しない3か月で45時間以上の時間外労働があったとき' do
        it '#unemployed_with_special_eligible? が false である'
      end
    end

    context '特定理由離職者に該当する場合' do
      it '#unemployed_with_special_reason? が true である'
    end

    context '特定理由離職者に該当しない場合' do
      it '#unemployed_with_special_reason? が false である'
    end
  end
end
