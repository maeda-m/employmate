require 'rails_helper'

RSpec.describe 'Surveys::Answers', type: :request do
  describe 'POST /surveys/:survey_id/answers' do
    describe '初回分析調査' do
      before do
        AnswerCondition.destroy_all
        Question.destroy_all
      end

      let(:survey) { questionnaire.survey }
      let(:questionnaire) { FactoryBot.create(:questionnaire, :with_initial_profile) }
      let(:unemployed_on_question) { FactoryBot.create(:question, :with_unemployed_on, questionnaire:) }
      let(:first_special_reason_question) { FactoryBot.create(:question, :with_special_reason, questionnaire:) }
      let(:second_special_reason_question) { FactoryBot.create(:question, :with_special_reason, questionnaire:) }

      context '質問分岐で未回答の質問が送信パラメータにあるとき' do
        before do
          available_question = first_special_reason_question
          except_question = second_special_reason_question
          FactoryBot.create(:answer_condition, :with_never_match,
                            question: except_question, condition_question: available_question)
        end

        it '未回答の質問を除外し、特定理由離職者と推定される' do
          expect do
            post survey_answers_path(survey_id: survey.id), params: {
              answers: {
                unemployed_on_question.id.to_s => { value: '' },
                first_special_reason_question.id.to_s => { value: 'yes' },
                second_special_reason_question.id.to_s => { value: '' }
              }
            }
          end.to change(User, :count).by(1)

          user = Session.find_by(session_id: session.id.private_id).user
          expect(user.profile.unemployed_on).to eq nil
          expect(user.profile.unemployed_with_special_reason).to eq true
        end
      end

      context '戻るボタンで回答不要の質問が送信パラメータにあるとき' do
        before do
          available_question = first_special_reason_question
          except_question = second_special_reason_question
          FactoryBot.create(:answer_condition, :with_never_match,
                            question: except_question, condition_question: available_question)
        end

        it '回答不要の質問を除外し、特定理由離職者と推定される' do
          expect do
            post survey_answers_path(survey_id: survey.id), params: {
              answers: {
                unemployed_on_question.id.to_s => { value: '' },
                first_special_reason_question.id.to_s => { value: 'yes' },
                second_special_reason_question.id.to_s => { value: 'no' }
              }
            }
          end.to change(User, :count).by(1)

          user = Session.find_by(session_id: session.id.private_id).user
          expect(user.profile.unemployed_on).to eq nil
          expect(user.profile.unemployed_with_special_reason).to eq true
        end
      end

      context '質問分岐なし、戻るボタンを押下しないで質問に回答したとき' do
        it '複数の回答内容がすべてyesのとき特定理由離職者と推定される' do
          expect do
            post survey_answers_path(survey_id: survey.id), params: {
              answers: {
                unemployed_on_question.id.to_s => { value: '2023-03-31' },
                first_special_reason_question.id.to_s => { value: 'yes' },
                second_special_reason_question.id.to_s => { value: 'yes' }
              }
            }
          end.to change(User, :count).by(1)

          user = Session.find_by(session_id: session.id.private_id).user
          expect(user.profile.unemployed_on).to eq Date.new(2023, 3, 31)
          expect(user.profile.unemployed_with_special_reason).to eq true
        end

        it '複数の回答内容がすべてnoのとき特定理由離職者と推定されない' do
          expect do
            post survey_answers_path(survey_id: survey.id), params: {
              answers: {
                unemployed_on_question.id.to_s => { value: '2022-02-22' },
                first_special_reason_question.id.to_s => { value: 'no' },
                second_special_reason_question.id.to_s => { value: 'no' }
              }
            }
          end.to change(User, :count).by(1)

          user = Session.find_by(session_id: session.id.private_id).user
          expect(user.profile.unemployed_on).to eq Date.new(2022, 2, 22)
          expect(user.profile.unemployed_with_special_reason).to eq false
        end

        it '複数の回答内容にnoが含まれるとき特定理由離職者と推定されない' do
          expect do
            post survey_answers_path(survey_id: survey.id), params: {
              answers: {
                unemployed_on_question.id.to_s => { value: '2011-11-01' },
                first_special_reason_question.id.to_s => { value: 'no' },
                second_special_reason_question.id.to_s => { value: 'yes' }
              }
            }
          end.to change(User, :count).by(1)

          user = Session.find_by(session_id: session.id.private_id).user
          expect(user.profile.unemployed_on).to eq Date.new(2011, 11, 1)
          expect(user.profile.unemployed_with_special_reason).to eq false
        end
      end

      context 'やりなおしをしたとき' do
        it '初回のみ匿名ユーザーが登録され、戻るボタンで回答不要の質問が送信パラメータにあっても回答が上書きされる' do
          condition_question = unemployed_on_question
          special_eligible_question = FactoryBot.create(:question, :with_special_eligible, questionnaire:)
          FactoryBot.create(:answer_condition, condition_answer_value: '2023-02-28', question: special_eligible_question, condition_question:)

          expect do
            post survey_answers_path(survey_id: survey.id), params: {
              answers: {
                unemployed_on_question.id.to_s => { value: '2023-02-28' },
                special_eligible_question.id.to_s => { values: { '0' => 100 } }
              }
            }
          end.to change(User, :count).by(1)

          user = Session.find_by(session_id: session.id.private_id).user
          expect(user.profile.unemployed_on).to eq Date.new(2023, 2, 28)
          expect(user.profile.unemployed_with_special_eligible).to eq true
          expect(user.answers.count).to eq 1

          expect do
            post survey_answers_path(survey_id: survey.id), params: {
              answers: {
                unemployed_on_question.id.to_s => { value: '2023-04-01' },
                special_eligible_question.id.to_s => { values: { '0' => 100 } }
              }
            }
          end.to change(User, :count).by(0)

          user.reload
          expect(user.profile.unemployed_on).to eq Date.new(2023, 4, 1)
          expect(user.profile.unemployed_with_special_eligible).to eq false
          expect(user.answers.count).to eq 2
        end
      end
    end
  end
end
