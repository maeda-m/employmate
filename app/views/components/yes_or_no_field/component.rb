# frozen_string_literal: true

class YesOrNoField::Component < RadioButtonField::Component
  def choices
    {
      yes: 'はい',
      no: 'いいえ'
    }
  end
end
