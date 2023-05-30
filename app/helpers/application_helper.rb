# frozen_string_literal: true

module ApplicationHelper
  def controller_name_to_css
    controller_path.sub('/', '-')
  end

  def caption_with_back_icon
    tag.span('戻る', class: 'fa-solid fa-chevron-left')
  end
end
