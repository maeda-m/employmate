Feature: 特定の環境変数を設定しなければ検索エンジンのインデックス登録を拒否すること
  Background:
    Given 環境変数"ROBOTS_INDEX"が未設定である

  Scenario: 環境変数なし
    When ブラウザで"/robots"にアクセスする
    Then レスポンス形式が"text/plain"である
    And レスポンス本文に"Disallow: /"とある

  Scenario: 環境変数あり
    When 環境変数"ROBOTS_INDEX"に"yes"を設定する

    When ブラウザで"/robots"にアクセスする
    Then レスポンス形式が"text/plain"である
    And レスポンス本文に"Disallow: /"とない
