# frozen_string_literal: true

class AnswerCondition < ApplicationRecord
  belongs_to :question
  belongs_to :condition_question, class_name: 'Question'

  def fulfilled?(answer_values)
    answer_value = answer_values[condition_question.id].to_s

    return true if answered? && answer_value.present?
    return true if equal? && answer_value == condition_answer_value

    false
  end
end
