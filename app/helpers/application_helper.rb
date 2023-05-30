# frozen_string_literal: true

module ApplicationHelper
  def controller_name_to_css
    controller_path.sub('/', '-')
  end

  def caption_with_back_icon
    tag.span('戻る', class: 'fa-solid fa-chevron-left')
  end

  def link_to_terms_of_service
    link_to('利用規約', terms_of_service_path, target: '_blank', rel: 'noopener')
  end

  def link_to_privacy_policy
    link_to('プライバシーポリシー', privacy_policy_path, target: '_blank', rel: 'noopener')
  end
end
