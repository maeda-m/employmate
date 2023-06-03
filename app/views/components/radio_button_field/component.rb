# frozen_string_literal: true

class RadioButtonField::Component < AnswerFieldComponent
  GRID_COLUMN_START = 4

  def choices
    raise NotImplementedError
  end

  def choice_action
  end

  def choice_wrapper
    choices.size >= GRID_COLUMN_START ? 'grid' : ''
  end
end
