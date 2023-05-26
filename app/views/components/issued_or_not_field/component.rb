# frozen_string_literal: true

class IssuedOrNotField::Component < YesOrNoField::Component
  def choice_action
    'input->survey-tasks#switchRequired'
  end

  def render?
    @user.issuances.count.zero?
  end
end
