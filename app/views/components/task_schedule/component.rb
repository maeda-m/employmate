# frozen_string_literal: true

class TaskSchedule::Component < ApplicationViewComponent
  def initialize(user:)
    super
    @user = user
  end

  def tasks
    location = 'ハローワーク'
    [
      { task_category: TaskCategory.first, title: '就労可否の証明書を入手する', location: },
      { task_category: TaskCategory.first, title: '求職者マイページアカウント登録をする', location: '自宅' },
      { task_category: TaskCategory.third, title: '離職票を提出する', help: help_message, location: },
      { task_category: TaskCategory.fourth, title: '雇用保険説明会に出席する', location: },
      { task_category: TaskCategory.fifth, title: '失業認定申告書を提出する', location: },
      { task_category: TaskCategory.sixth, title: '初回の給付金振込予定日です', location: }
    ].map do |attrs|
      task = @user.tasks.new
      ActiveDecorator::Decorator.instance.decorate(task)
      task.attributes = attrs

      task
    end
  end

  def help_message
    user_profile = @user.profile

    messages = [
      '【持ち物】',
      '・離職票１，２',
      '・マイナンバーカード',
      '・キャッシュカード'
    ]
    messages << '・残業時間の記載がある勤務実績表や給与明細書' if user_profile.unemployed_with_special_eligible?
    messages << '・医師の診断書（発病や負傷時、退職日前後のもの）' if user_profile.unemployed_with_special_reason?
    messages << '・就労可否の証明書' if user_profile.unemployed_with_special_reason?

    messages.join("\n")
  end
end
