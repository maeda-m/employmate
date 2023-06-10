# frozen_string_literal: true

class User < ApplicationRecord
  has_one :profile, dependent: :destroy
  has_one :approval, dependent: :destroy

  has_many :answers, dependent: :destroy
  has_many :sessions, dependent: :destroy
  has_many :tasks, dependent: :destroy
  has_many :issuances, dependent: :destroy

  validates :google_id, uniqueness: true, allow_nil: true

  # See: https://github.com/Sorcery/sorcery/blob/v0.16.5/lib/sorcery/model.rb#L86
  def self.authenticate(*credentials, &block)
    google_id = credentials[0]
    return authentication_response(return_value: false, failure: :invalid_login, &block) if google_id.blank?

    user = find_by_hash_google_id(google_id)
    return authentication_response(failure: :invalid_login, &block) unless user

    authentication_response(user:, return_value: user, &block)
  end

  # See: https://github.com/Sorcery/sorcery/blob/v0.16.5/lib/sorcery/model.rb#L144
  def self.authentication_response(options = {})
    yield(options[:user], options[:failure]) if block_given?

    options[:return_value]
  end

  def self.find_by_hash_google_id(google_id)
    hash = Digest::SHA512.hexdigest(google_id)

    find_by(google_id: hash)
  end

  def register(google_id)
    hash = Digest::SHA512.hexdigest(google_id)

    update!(google_id: hash)
  end

  def registered?
    !!google_id
  end

  def anonymous?
    !registered?
  end

  def recommend
    words = ['基本手当']

    if profile.recommended_to_public_vocational_training?
      words << '技能習得手当'
      words << '寄宿手当'
    end

    words.to_sentence
  end

  def create_tasks
    ActiveRecord::Base.transaction do
      tasks.create!(position: 1, task_category: TaskCategory.first, title: 'ハローワークで就労可否の証明書を入手する') if profile.unemployed_with_special_reason?
      tasks.create!(position: 2, task_category: TaskCategory.first, title: '求職者マイページアカウント登録をする')
      tasks.create!(position: 3, task_category: TaskCategory.second, title: '就労可否の証明書を医師に記入してもらう') if profile.unemployed_with_special_reason?
      tasks.create!(position: 4, task_category: TaskCategory.third, title: '離職票を受け取る')
      tasks.create!(position: 5, task_category: TaskCategory.third, title: '離職票をハローワークに提出する')
      tasks.create!(position: 6, task_category: TaskCategory.third, title: '雇用保険の失業等給付受給資格者のしおりを入手する', survey: Survey.approved_release_form)
      tasks.create!(position: 7, task_category: TaskCategory.fourth, title: 'ハローワークで雇用保険説明会に出席する')
      tasks.create!(position: 8, task_category: TaskCategory.fourth, title: '雇用保険受給資格者証を入手する', survey: Survey.issued_employment_insurance_eligibility_card)
      tasks.create!(position: 9, task_category: TaskCategory.fifth, title: 'ハローワークで失業認定申告書を提出する')
    end
  end

  def update_profile_by!(survey:, answer_values:)
    attrs = survey.answer_values_to_profile_attributes(answer_values:)
    profile.update!(attrs)
  end

  def find_todo_task(survey:)
    tasks.todo.find_by!(survey_id: survey.id)
  end
end
