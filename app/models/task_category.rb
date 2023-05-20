# frozen_string_literal: true

class TaskCategory < ActiveYaml::Base
  include ActiveHash::Associations

  class << self
    delegate :to_a, to: :all, prefix: true
    delegate :second, :third, :fourth, :fifth, to: :all_to_a

    def sixth
      find(6)
    end
  end

  def now?
    label_attribute.blank?
  end

  def estimated_date(user_profile)
    user_profile.send(label_attribute)
  end

  def fixed_date?(user_profile, date)
    fixed_attribute = "fixed_#{label_attribute}"
    return false unless user_profile.respond_to?(fixed_attribute)

    fixed_date = user_profile.send(fixed_attribute)

    fixed_date == date
  end
end
