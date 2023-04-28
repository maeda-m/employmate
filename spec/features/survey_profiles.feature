Feature: 初回分析調査の質問ページ

  Scenario: はじめる、次へ、戻るが機能すること
    Given 未ログインである
    And ブラウザで"/"にアクセスする

    When ボタン"はじめる"をクリックする
    Then ページ本文に"あなたの状況や希望を教えてください。"とある
    And ページ本文に"Q. 退職日または予定日はいつですか？"とある
    And ボタン"戻る"がある
    And ボタン"次へ"がある
    And ページ本文に"退職前の状況を教えてください。残業時間の記載がある勤務実績表や給与明細書があれば準備してください。"とない
    And ページ本文に"退職前の状況を教えてください。医師の診断書があれば準備してください。"とない

    When フィールド"Q. 退職日または予定日はいつですか？"に"2023-02-28"と入力する
    And ボタン"次へ"をクリックする
    Then ページ本文に"Q. 病気やケガで労働が困難な状況ですか？"とある
    And ボタン"戻る"がある
    And ボタン"次へ"がない

    When 単一選択ボタン"いいえ"を選ぶ
    Then ページ本文に"Q. 1か月以上は治療が必要な状況ですか？"とある
    And ボタン"戻る"がある
    And ボタン"次へ"がない

    When ボタン"戻る"をクリックする
    Then ページ本文に"Q. 病気やケガで労働が困難な状況ですか？"とある
    And ボタン"戻る"がある
    And ボタン"次へ"がない

    When ボタン"戻る"をクリックする
    Then ページ本文に"Q. 退職日または予定日はいつですか？"とある
    And ボタン"戻る"がある
    And ボタン"次へ"がある

    When ボタン"戻る"をクリックする
    Then ページ本文に"病気やケガで退職した（する）あなたの事情に合った雇用保険の失業等給付金を探します。"とある
    And ボタン"戻る"がない
    And ボタン"次へ"がない
