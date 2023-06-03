# frozen_string_literal: true

class YesOrNoWithNotApplicableField::Component < RadioButtonField::Component
  def choices
    {
      yes: 'はい',
      no: 'いいえ',
      not_applicable: 'わからない'
    }
  end
end
