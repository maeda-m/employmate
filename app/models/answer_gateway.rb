# frozen_string_literal: true

class AnswerGateway < ActiveYaml::Base
  def self.to_profile_attributes(survey, answers)
    questionnaires = survey.questionnaires.eager_load(:questions).order(:position)
    questions = questionnaires.merge(Question.where.not(answer_gateway_rule: nil)).map(&:questions).flatten

    to_profile_value = proc { |question| question.to_profile_value(answers[question.id.to_s]) }
    questions_with_answer_gateways = questions.group_by(&:answer_gateway)
    questions_with_answer_gateways.each_with_object({}).each do |questions_with_answer_gateway, attributes|
      gateway = questions_with_answer_gateway.first
      questions = questions_with_answer_gateway.last

      value = if gateway.rule.inquiry.unemployed_on?
                questions.map(&to_profile_value).first
              else
                questions.map(&to_profile_value).all?
              end

      attributes[gateway.rule] = value
    end
  end

  def eval_date(value)
    Date.parse(value)
  end

  def eval_yes_or_no(value)
    value == 'yes'
  end

  def eval_overtime(overtimes)
    return false unless overtimes.any? { |v| v >= 45 }
    return true if overtimes.any? { |v| v >= 100 }

    result = false
    5.times do |i|
      result = true if (overtimes.slice(i, 2).sum(0.0) / 2) >= 80
    end
    4.times do |i|
      result = true if overtimes.slice(i, 3).all? { |v| v >= 45 }
    end

    result
  end
end
