Feature: Google で登録する
  Scenario: 初回分析回答が未回答のユーザーで「Googleで登録」を試みる
    Given 未ログインである

    When ブラウザで"/users/123/profile"にアクセスする
    Then ボタン"Googleで登録"がない
    And ボタン"はじめる"がある

  Scenario: 初回分析回答直後のユーザーで「Googleで登録」する
    Given ユーザー"初回分析回答直後"でログインする

    When ブラウザで"/users/:user_id/profile"にアクセスする
    Then ボタン"Googleで登録"がある
    And ボタン"はじめる"がない

  Scenario: すでにGoogleID連携済みのユーザーで「Googleで登録」を試みる
    Given ユーザー"GoogleID連携済み"でログインする
    And 会員登録時にやることリストが退職日"2023/02/28"として作成されている

    When ブラウザで"/users/:user_id/profile"にアクセスする
    Then ボタン"Googleで登録"がない
    And ボタン"はじめる"がない
    And ページ本文に"初回の給付金振込予定日は"とある
