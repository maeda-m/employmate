# frozen_string_literal: true

ActiveRecord::Base.transaction do
  records = [
    {
      survey: Survey.profiles.first,
      questionnaires: [
        {
          title: 'あなたの状況や希望を教えてください。',
          questions: [
            {

              body: 'Q. 退職日または予定日はいつですか？',
              answer_component_type: 'date',
              required: true
            },
            {

              body: 'Q. 病気やケガで労働が困難な状況ですか？',
              answer_component_type: 'yes_or_no',
              required: true
            },
            {

              body: 'Q. 1か月以上は治療が必要な状況ですか？',
              answer_component_type: 'yes_or_no',
              required: true
            },
            {

              body: 'Q. これまでの職務経歴から異なる技能習得によって再就職を目指したいですか？',
              answer_component_type: 'yes_or_no',
              required: true
            }
          ]
        },
        {
          title: '退職前の状況を教えてください。残業時間の記載がある勤務実績表や給与明細書があれば準備してください。',
          questions: [
            {
              body: 'Q. 退職前の勤務実績で、休職期間を除いた6か月間のうち45時間以上の時間外労働がひと月でもありましたか？',
              answer_component_type: 'yes_or_no_with_not_applicable',
              required: true
            },
            {
              body: 'Q. 退職前の勤務実績で、最後に勤務した月を教えてください。',
              answer_component_type: 'month',
              required: true
            },
            {
              body: 'Q. 6か月間の残業時間（時間外労働）を教えてください。',
              answer_component_type: 'overtime',
              required: true
            }
          ]
        },
        {
          title: '退職前の状況を教えてください。医師の診断書があれば準備してください。',
          questions: [
            {
              body: 'Q. 医師の診断書などで退職時に仕事が困難であったかを証明できますか？',
              answer_component_type: 'yes_or_no',
              required: true
            },
            {
              body: 'Q. あなたの病気やケガに対して会社側から勤務可能な業務に配置転換がありましたか？',
              answer_component_type: 'yes_or_no',
              required: true
            },
            {
              body: 'Q. 配置転換後の業務や通勤が続けられず退職しましたか？',
              answer_component_type: 'yes_or_no',
              required: true
            }
          ]
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
    end
  end

rescue StandardError => e
  Rails.logger.debug e.inspect
  raise ActiveRecord::Rollback
end
