# frozen_string_literal: true

class YesOrNoField::Component < RadioButtonField::Component
  def choices
    {
      yes: 'はい',
      no: 'いいえ'
    }
  end

  def choice_action
    'input->survey-profiles#showNextQuestionWithoutCurrentQuestionValid'
  end
end
