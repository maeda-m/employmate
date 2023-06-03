# frozen_string_literal: true

class Profile::Component < ApplicationViewComponent
  def initialize(record:)
    super
    @record = record
  end

  def recommenders
    words = ['基本手当']

    if @record.recommended_to_public_vocational_training?
      words << '技能習得手当'
      words << '寄宿手当'
    end

    words.to_sentence
  end
end
