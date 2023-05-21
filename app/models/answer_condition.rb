# frozen_string_literal: true

class AnswerCondition < ApplicationRecord
  belongs_to :question
  belongs_to :condition_question, class_name: 'Question'

  def fulfilled?(answers)
    answer = answers[condition_question.id.to_s]
    return false if answer.nil?

    answer_value = answer['value']
    return true if answered? && answer_value.present?
    return true if equal? && answer_value == condition_answer_value

    false
  end
end
