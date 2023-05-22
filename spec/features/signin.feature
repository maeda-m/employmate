Feature: Googleでログインする
  Scenario: 初回分析回答が未回答のユーザーで「Googleでログイン」を試みる
    Given 未ログインである

    When ブラウザで"/"にアクセスする
    Then ボタン"Googleでログイン"がある
    And ボタン"はじめる"がある

  Scenario: 初回分析回答直後のユーザーで「Googleでログイン」を試みる
    Given ユーザー"初回分析回答直後"でログインする

    When ブラウザで"/"にアクセスする
    Then ボタン"Googleでログイン"がある
    And ボタン"はじめる"がある

  Scenario: すでにGoogleID連携済みのユーザーで「Googleでログイン」をする
    Given ユーザー"GoogleID連携済み"でログインする
    And 会員登録時にやることリストが退職日"2023/02/28"として作成されている

    When ブラウザで"/"にアクセスする
    Then ボタン"Googleでログイン"がない
    And ボタン"はじめる"がない
    And ページ本文に"初回の給付金振込予定日は"とある
