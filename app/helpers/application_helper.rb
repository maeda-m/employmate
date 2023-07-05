# frozen_string_literal: true

module ApplicationHelper
  def header_content(page_title)
    return tag.h1(image_tag('logo.svg', alt: '雇用保険給付の相棒')) unless page_title

    end_of_sentence = '。'
    return tag.h1(page_title) unless page_title.end_with?(end_of_sentence)

    lines = page_title.split(end_of_sentence).map { |line| "#{line}#{end_of_sentence}" }
    tag.hgroup do
      concat(tag.h1(lines[0]))
      concat(tag.p(lines[1]))
    end
  end

  def default_meta_tags
    {
      reverse: true,
      site: '雇用保険給付の相棒（Employmate）',
      description: '病気やケガで退職した後、働く意思がある60歳未満のあなたと雇用保険制度をつなげるサービスです。',
      keywords: '雇用保険給付, 雇用保険制度, 雇用保険受給資格者証',
      charset: 'utf-8',
      viewport: 'width=device-width,initial-scale=1',
      # See: https://ogp.me/
      og: {
        title: :title,
        type: 'website',
        description: :description,
        image: "#{root_url}/ogp.png",
        url: root_url
      },
      # See: https://developer.twitter.com/ja/docs/tweets/optimize-with-cards/guides/getting-started
      twitter: {
        card: 'summary',
        creator: '@minoru_maeda'
      }
    }
  end

  def help_message(title:)
    tag.div(class: 'help-message') do
      header = tag.p(class: 'title') do
        simple_format(h(title), {}, wrapper_tag: 'span')
      end

      concat(header)
      yield if block_given?
    end
  end

  def link_to_terms_of_service
    link_to('利用規約', terms_of_service_path, target: '_blank', rel: 'noopener')
  end

  def link_to_privacy_policy
    link_to('プライバシーポリシー', privacy_policy_path, target: '_blank', rel: 'noopener')
  end
end
