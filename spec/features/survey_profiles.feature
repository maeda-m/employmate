Feature: 初回分析調査の質問ページ

  Scenario: はじめる、質問分岐なしの次へと戻るが機能すること
    Given 未ログインである
    And ブラウザで"/"にアクセスする
    And ボタン"はじめる"をクリックする

    Then ページ本文に"あなたの状況や希望を教えてください。"とある
    And ページ本文に"Q. 退職日または予定日はいつですか？"とある
    And ボタン"戻る"がある
    And ボタン"次へ"がある

    When フィールド"Q. 退職日または予定日はいつですか？"に"2023-02-28"と入力する
    And ボタン"次へ"をクリックする
    Then ページ本文に"Q. 病気やケガで労働が困難な状況ですか？"とある
    And ボタン"戻る"がある
    And ボタン"次へ"がある

    When 単一選択ボタン"はい"を選ぶ
    Then ページ本文に"Q. 1か月以上は治療が必要な状況ですか？"とある
    And ボタン"戻る"がある
    And ボタン"次へ"がある

    When ボタン"戻る"をクリックする
    Then ページ本文に"Q. 病気やケガで労働が困難な状況ですか？"とある
    And ボタン"戻る"がある
    And ボタン"次へ"がある

    When ボタン"次へ"をクリックする
    Then ページ本文に"Q. 1か月以上は治療が必要な状況ですか？"とある
    And ボタン"戻る"がある
    And ボタン"次へ"がある

    When ボタン"戻る"をクリックする
    Then ページ本文に"Q. 病気やケガで労働が困難な状況ですか？"とある
    And ボタン"戻る"がある
    And ボタン"次へ"がある

    When ボタン"戻る"をクリックする
    Then ページ本文に"Q. 退職日または予定日はいつですか？"とある
    And ボタン"戻る"がある
    And ボタン"次へ"がある

    When ボタン"戻る"をクリックする
    Then ページ本文に"病気やケガで退職した（する）あなたの事情に合った雇用保険の失業等給付金を探します。"とある
    And ボタン"戻る"がない
    And ボタン"次へ"がない

  Scenario: 質問分岐なしのすべての質問回答後、やりなおし（質問分岐ありの最小の質問回答）が機能すること
    Given 未ログインである
    And ブラウザで"/"にアクセスする
    And ボタン"はじめる"をクリックする

    Then ページ本文に"あなたの状況や希望を教えてください。"とある
    And ページ本文に"Q. 退職日または予定日はいつですか？"とある
    And ページ本文に"退職前の状況を教えてください。残業時間の記載がある勤務実績表や給与明細書があれば準備してください。"とない
    And ページ本文に"退職前の状況を教えてください。医師の診断書があれば準備してください。"とない

    When フィールド"Q. 退職日または予定日はいつですか？"に"2023-02-28"と入力する
    And ボタン"次へ"をクリックする
    Then ページ本文に"Q. 病気やケガで労働が困難な状況ですか？"とある

    When 単一選択ボタン"はい"を選ぶ
    Then ページ本文に"Q. 1か月以上は治療が必要な状況ですか？"とある

    When 単一選択ボタン"いいえ"を選ぶ
    Then ページ本文に"Q. これまでの職務経歴から異なる技能習得によって再就職を目指したいですか？"とある

    When 単一選択ボタン"はい"を選ぶ
    Then ページ本文に"退職前の状況を教えてください。残業時間の記載がある勤務実績表や給与明細書があれば準備してください。"とある
    And ページ本文に"Q. 退職前の勤務実績で、休職期間を除いた6か月間のうち45時間以上の時間外労働がひと月でもありましたか？"とある
    And ページ本文に"あなたの状況や希望を教えてください。"とない
    And ページ本文に"退職前の状況を教えてください。医師の診断書があれば準備してください。"とない

    When 単一選択ボタン"はい"を選ぶ
    Then ページ本文に"Q. 退職前の勤務実績で、最後に勤務した月を教えてください。"とある

    When セレクトボックス「年選択」の"2022"を選ぶ
    And セレクトボックス「月選択」の"04"を選ぶ
    And ボタン"次へ"をクリックする
    Then ページ本文に"Q. 6か月間の残業時間（時間外労働）を教えてください。"とある

    When フィールド"2021/11"に"20"と入力する
    And フィールド"2021/12"に"30"と入力する
    And フィールド"2022/01"に"45"と入力する
    And フィールド"2022/02"に"60"と入力する
    And フィールド"2022/03"に"80"と入力する
    And フィールド"2022/04"に"0"と入力する
    And ボタン"次へ"をクリックする

    Then ページ本文に"退職前の状況を教えてください。医師の診断書があれば準備してください。"とある
    And ページ本文に"Q. 医師の診断書などで退職時に仕事が困難であったかを証明できますか？"とある
    And ページ本文に"あなたの状況や希望を教えてください。"とない
    And ページ本文に"退職前の状況を教えてください。残業時間の記載がある勤務実績表や給与明細書があれば準備してください。"とない

    When 単一選択ボタン"はい"を選ぶ
    Then ページ本文に"Q. あなたの病気やケガに対して会社側から勤務可能な業務に配置転換がありましたか？"とある

    When 単一選択ボタン"はい"を選ぶ
    Then ページ本文に"Q. 配置転換後の業務や通勤が続けられず退職しましたか？"とある

    When 単一選択ボタン"はい"を選ぶ
    Then ボタン"結果を見る"がある

    When ボタン"結果を見る"をクリックする

    Then ページ本文に"あなたの状況や希望に合う雇用保険制度は"とある
    And ページ本文に"基本手当"とある
    And ページ本文に"技能習得手当"とある
    And ページ本文に"寄宿手当"とある

    Then ページ本文に"今後の予定は次のとおりです。"とある
    And 次のとおり、表がある:
      | いつ頃   | どこで       | なにをどうする                       |
      | いますぐ | ハローワーク | 就労可否の証明書を入手する           |
      | いますぐ | 自宅         | 求職者マイページアカウント登録をする |
      | 03/11頃  | ハローワーク | 離職票を提出する                     |
      | 03/22頃  | ハローワーク | 雇用保険説明会に出席する             |
      | 03/27の週| ハローワーク | 失業認定申告書を提出する             |
      | 04/03頃  | ハローワーク | 初回の給付金振込予定日です           |

    And ページ本文に"残業時間の記載がある勤務実績表や給与明細書"とある
    And ページ本文に"医師の診断書（発病や負傷時、退職日前後のもの）"とある

    Then ボタン"やりなおす"がある
    And ボタン"Googleで登録"がある

    When ボタン"やりなおす"をクリックする
    Then ページ本文に"Q. 退職日または予定日はいつですか？"とある

    When フィールド"Q. 退職日または予定日はいつですか？"に"2023-03-31"と入力する
    And ボタン"次へ"をクリックする
    Then ページ本文に"Q. 病気やケガで労働が困難な状況ですか？"とある

    When 単一選択ボタン"はい"を選ぶ
    Then ページ本文に"Q. 1か月以上は治療が必要な状況ですか？"とある

    When 単一選択ボタン"いいえ"を選ぶ
    Then ページ本文に"Q. これまでの職務経歴から異なる技能習得によって再就職を目指したいですか？"とある

    When 単一選択ボタン"いいえ"を選ぶ
    Then ページ本文に"Q. 退職前の勤務実績で、休職期間を除いた6か月間のうち45時間以上の時間外労働がひと月でもありましたか？"とある

    When 単一選択ボタン"わからない"を選ぶ
    Then ページ本文に"Q. 医師の診断書などで退職時に仕事が困難であったかを証明できますか？"とある

    When 単一選択ボタン"いいえ"を選ぶ
    Then ページ本文に"Q. あなたの病気やケガに対して会社側から勤務可能な業務に配置転換がありましたか？"とある

    When 単一選択ボタン"いいえ"を選ぶ
    Then ボタン"結果を見る"がある

    When ボタン"結果を見る"をクリックする

    Then ページ本文に"あなたの状況や希望に合う雇用保険制度は"とある
    And ページ本文に"基本手当"とある
    And ページ本文に"技能習得手当"とない
    And ページ本文に"寄宿手当"とない

    Then ページ本文に"今後の予定は次のとおりです。"とある
    And 次のとおり、表がある:
      | いつ頃   | どこで       | なにをどうする                       |
      | いますぐ | ハローワーク | 就労可否の証明書を入手する           |
      | いますぐ | 自宅         | 求職者マイページアカウント登録をする |
      | 04/11頃  | ハローワーク | 離職票を提出する                     |
      | 04/20頃  | ハローワーク | 雇用保険説明会に出席する             |
      | 05/01の週| ハローワーク | 失業認定申告書を提出する             |
      | 07/07頃  | ハローワーク | 初回の給付金振込予定日です           |

    And ページ本文に"残業時間の記載がある勤務実績表や給与明細書"とない
    And ページ本文に"医師の診断書（発病や負傷時、退職日前後のもの）"とない

    Then ボタン"やりなおす"がある
    And ボタン"Googleで登録"がある

  Scenario: はじめる、質問分岐ありの次へと戻るが機能すること
    Given 未ログインである
    And ブラウザで"/"にアクセスする
    And ボタン"はじめる"をクリックする

    Then ページ本文に"Q. 退職日または予定日はいつですか？"とある

    When フィールド"Q. 退職日または予定日はいつですか？"に"2023-03-31"と入力する
    And ボタン"次へ"をクリックする
    Then ページ本文に"Q. 病気やケガで労働が困難な状況ですか？"とある

    When 単一選択ボタン"はい"を選ぶ
    Then ページ本文に"Q. 1か月以上は治療が必要な状況ですか？"とある

    When 単一選択ボタン"いいえ"を選ぶ
    Then ページ本文に"Q. これまでの職務経歴から異なる技能習得によって再就職を目指したいですか？"とある

    When 単一選択ボタン"いいえ"を選ぶ
    Then ページ本文に"Q. 退職前の勤務実績で、休職期間を除いた6か月間のうち45時間以上の時間外労働がひと月でもありましたか？"とある

    When 単一選択ボタン"いいえ"を選ぶ
    Then ページ本文に"Q. 医師の診断書などで退職時に仕事が困難であったかを証明できますか？"とある

    When 単一選択ボタン"はい"を選ぶ
    Then ページ本文に"Q. あなたの病気やケガに対して会社側から勤務可能な業務に配置転換がありましたか？"とある

    When 単一選択ボタン"はい"を選ぶ
    Then ページ本文に"Q. 配置転換後の業務や通勤が続けられず退職しましたか？"とある

    When ボタン"戻る"をクリックする
    Then ページ本文に"Q. あなたの病気やケガに対して会社側から勤務可能な業務に配置転換がありましたか？"とある

    When ボタン"戻る"をクリックする
    Then ページ本文に"Q. 医師の診断書などで退職時に仕事が困難であったかを証明できますか？"とある

    When ボタン"戻る"をクリックする
    Then ページ本文に"Q. 退職前の勤務実績で、休職期間を除いた6か月間のうち45時間以上の時間外労働がひと月でもありましたか？"とある

    When ボタン"戻る"をクリックする
    Then ページ本文に"Q. これまでの職務経歴から異なる技能習得によって再就職を目指したいですか？"とある

    When ボタン"戻る"をクリックする
    Then ページ本文に"Q. 1か月以上は治療が必要な状況ですか？"とある

    When ボタン"戻る"をクリックする
    Then ページ本文に"Q. 病気やケガで労働が困難な状況ですか？"とある

    When 単一選択ボタン"いいえ"を選ぶ
    Then ページ本文に"Q. これまでの職務経歴から異なる技能習得によって再就職を目指したいですか？"とある

    When 単一選択ボタン"はい"を選ぶ
    Then ページ本文に"Q. 退職前の勤務実績で、休職期間を除いた6か月間のうち45時間以上の時間外労働がひと月でもありましたか？"とある

    When 単一選択ボタン"わからない"を選ぶ
    Then ボタン"結果を見る"がある
