# frozen_string_literal: true

class RadioButtonField::Component < AnswerFieldComponent
  def choices
    raise NotImplementedError
  end
end
