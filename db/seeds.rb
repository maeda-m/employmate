# frozen_string_literal: true

ActiveRecord::Base.transaction do
  records = [
    {
      survey: Survey.initial_profile,
      questionnaires: [
        {
          title: 'あなたの状況や希望を教えてください。',
          questions: [
            {
              body: 'Q. 退職日または予定日はいつですか？',
              answer_component_type: 'date',
              answer_gateway_rule: 'unemployed_on'
            },
            {
              body: 'Q. 病気やケガで労働が困難な状況ですか？',
              answer_component_type: 'yes_or_no',
              answer_gateway_rule: 'unemployed_with_special_reason'
            },
            {
              body: 'Q. 1か月以上は治療が必要な状況ですか？',
              answer_component_type: 'yes_or_no',
              answer_gateway_rule: 'recommended_to_extension_of_benefit_receivable_period'
            },
            {
              body: 'Q. これまでの職務経歴から異なる技能習得によって再就職を目指したいですか？',
              answer_component_type: 'yes_or_no',
              answer_gateway_rule: 'recommended_to_public_vocational_training'
            }
          ],
          conditions: [
            {
              question_position: 3,
              condition_question_position: 2,
              equal: true,
              condition_answer_value: 'yes'
            }
          ]
        },
        {
          title: '退職前の状況を教えてください。残業時間の記載がある勤務実績表や給与明細書があれば準備してください。',
          questions: [
            {
              body: 'Q. 退職前の勤務実績で、休職期間を除いた6か月間のうち45時間以上の時間外労働がひと月でもありましたか？',
              answer_component_type: 'yes_or_no_with_not_applicable'
            },
            {
              body: 'Q. 退職前の勤務実績で、最後に勤務した月を教えてください。',
              answer_component_type: 'month'
            },
            {
              body: 'Q. 6か月間の残業時間（時間外労働）を教えてください。',
              answer_component_type: 'overtime',
              answer_gateway_rule: 'unemployed_with_special_eligible'
            }
          ],
          conditions: [
            {
              question_position: 6,
              condition_question_position: 5,
              equal: true,
              condition_answer_value: 'yes'
            },
            {
              question_position: 7,
              condition_question_position: 6,
              answered: true
            }
          ]
        },
        {
          title: '退職前の状況を教えてください。医師の診断書があれば準備してください。',
          questions: [
            {
              body: 'Q. 医師の診断書などで退職時に仕事が困難であったかを証明できますか？',
              answer_component_type: 'yes_or_no',
              answer_gateway_rule: 'unemployed_with_special_reason'
            },
            {
              body: 'Q. あなたの病気やケガに対して会社側から勤務可能な業務に配置転換がありましたか？',
              answer_component_type: 'yes_or_no'
            },
            {
              body: 'Q. 配置転換後の業務や通勤が続けられず退職しましたか？',
              answer_component_type: 'yes_or_no',
              answer_gateway_rule: 'unemployed_with_special_reason'
            }
          ],
          conditions: [
            {
              question_position: 8,
              condition_question_position: 2,
              equal: true,
              condition_answer_value: 'yes'
            },
            {
              question_position: 9,
              condition_question_position: 8,
              answered: true
            },
            {
              question_position: 10,
              condition_question_position: 9,
              equal: true,
              condition_answer_value: 'yes'
            }
          ]
        }
      ]
    },
    {
      survey: Survey.approved_release_form,
      questionnaires: [
        {
          title: 'しおりの表紙について教えてください。',
          questions: [
            {
              body: 'しおりを受け取った日',
              answer_component_type: 'date'
            },
            {
              body: '雇用保険説明会の日付',
              answer_component_type: 'date',
              answer_gateway_rule: 'fixed_explanitory_seminar_on_for_employment_insurance'
            },
            {
              body: '失業認定日の型',
              answer_component_type: 'week_type',
              answer_gateway_rule: 'week_type_for_unemployment_certification'
            },
            {
              body: '失業認定日の曜日',
              answer_component_type: 'day_of_week',
              answer_gateway_rule: 'day_of_week_for_unemployment_certification'
            },
            {
              body: '最初の失業認定日',
              answer_component_type: 'date',
              answer_gateway_rule: 'fixed_first_unemployment_certification_on'
            }
          ],
          conditions: []
        }
      ]
    },
    {
      survey: Survey.issued_employment_insurance_eligibility_card,
      questionnaires: [
        {
          title: '雇用保険受給資格者証について教えてください。',
          questions: [
            {
              body: '仮である記載やしるしがありますか？',
              answer_component_type: 'issued_or_not'
            },
            {
              body: '離職理由の番号',
              answer_component_type: 'reason_code',
              answer_gateway_rule: 'reason_code_for_loss_of_employment'
            },
            {
              body: '交付の日付',
              answer_component_type: 'date'
            }
          ],
          conditions: []
        }
      ]
    }
  ]

  question_position = 0
  records.each do |record|
    survey = record[:survey]

    questionnaires = record[:questionnaires]
    questionnaires.each.with_index do |questionnaire_attrs, i|
      questionnaire_attrs[:position] = i.next
      questionnaire = survey.questionnaires.find_by(title: questionnaire_attrs[:title])
      questionnaire ||= survey.questionnaires.create!(questionnaire_attrs.slice(:title, :position))

      questions = questionnaire_attrs[:questions]
      questions.each do |question_attrs|
        question_position += 1
        question_attrs[:position] = question_position
        question = questionnaire.questions.find_by(body: question_attrs[:body])
        questionnaire.questions.create!(question_attrs) unless question
      end

      conditions = questionnaire_attrs[:conditions]
      conditions.each do |condition_attrs|
        question = Question.find_by(position: condition_attrs.delete(:question_position))
        condition_question = Question.find_by(position: condition_attrs.delete(:condition_question_position))

        condition_attrs[:condition_question] = condition_question
        question.create_answer_condition!(condition_attrs) unless question.answer_condition
      end
    end
  end
rescue StandardError => e
  Rails.logger.debug e.inspect
  raise ActiveRecord::Rollback
end
