# frozen_string_literal: true

class TaskSchedule::Component < ApplicationViewComponent
  def initialize(user:)
    super
    @user = user
  end

  def tasks
    [
      @user.tasks.new(task_category: TaskCategory.first, title: 'ハローワークで就労可否の証明書を入手する'),
      @user.tasks.new(task_category: TaskCategory.first, title: '求職者マイページアカウント登録をする'),
      @user.tasks.new(task_category: TaskCategory.third, title: "離職票をハローワークに提出する\n#{required_items.join("\n")}"),
      @user.tasks.new(task_category: TaskCategory.fourth, title: 'ハローワークで雇用保険説明会に出席する'),
      @user.tasks.new(task_category: TaskCategory.fifth, title: 'ハローワークで失業認定申告書を提出する'),
      @user.tasks.new(task_category: TaskCategory.sixth, title: '初回の給付金振込予定日です')
    ]
  end

  def required_items
    user_profile = @user.profile

    items = [
      '【持ち物】',
      '・離職票１，２',
      '・マイナンバーカード',
      '・キャッシュカード'
    ]
    items << '・残業時間の記載がある勤務実績表や給与明細書' if user_profile.unemployed_with_special_eligible?
    items << '・医師の診断書（発病や負傷時、退職日前後のもの）' if user_profile.unemployed_with_special_reason?
    items << '・就労可否の証明書' if user_profile.unemployed_with_special_reason?

    items
  end
end
