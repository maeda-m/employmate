Feature: やることリストの進行度
  Scenario: やることリストを進めると初回の給付金振込予定日が更新される
    Given ユーザー"初回分析で特定理由離職者と推定"でログインする
    And 会員登録時にやることリストが退職日"2023/02/28"として作成されている

    When ブラウザで"/users/:user_id"にアクセスする
    Then ページヘッダーに画像"雇用保険給付の相棒"とある
    And ページ本文に"初回の給付金振込予定日は"とある
    And ページ本文に"04/03頃"とある
    And ページ本文に"完了した予定はありません。"とある

    When チェックボックス"雇用保険の失業等給付受給資格者のしおりを入手する"をクリックする
    Then ページヘッダーに"しおりの表紙について教えてください。"とある
    And ページ本文に"しおりを受け取った日"とある
    And ページ本文に"雇用保険説明会の日付"とある
    And ページ本文に"失業認定日の型"とある
    And ページ本文に"失業認定日の曜日"とある
    And ページ本文に"最初の失業認定日"とある

    When カレンダー"しおりを受け取った日"に"2023/03/07"と入力する
    And カレンダー"雇用保険説明会の日付"に"2023/03/15"と入力する
    And 単一選択ボタン"1"を選ぶ
    And 単一選択ボタン"火"を選ぶ
    And カレンダー"最初の失業認定日"に"2023/03/28"と入力する
    And ボタン"完了にする"をクリックする

    Then ページ本文に"初回の給付金振込予定日は"とある
    And ページ本文に"04/04頃"とある
    And トースト"完了にしました。"がある

    Then 次のとおり、"03/15"の未完了のやることリストがある:
      | タイトル                                         |
      | ハローワークで雇用保険説明会に出席する           |
      | 雇用保険受給資格者証を入手する                   |

    Then 次のとおり、"03/28"の未完了のやることリストがある:
      | タイトル                                         |
      | ハローワークで失業認定申告書を提出する           |

    Then 次のとおり、完了分のやることリストがある:
      | タイトル                                         |
      | 雇用保険の失業等給付受給資格者のしおりを入手する |

    When チェックボックス"雇用保険受給資格者証を入手する"をクリックする
    Then ページヘッダーに"雇用保険受給資格者証について教えてください。"とある
    And ページ本文に"仮である記載やしるしがありますか？"とある
    And ページ本文に"離職理由の番号"とある
    And ページ本文に"交付の日付"とある

    When 単一選択ボタン"はい"を選ぶ
    And ボタン"完了にする"をクリックする

    Then トースト"完了にしました。"がある

    Then 次のとおり、"03/15"の未完了のやることリストがある:
      | タイトル                                         |
      | ハローワークで雇用保険説明会に出席する           |

    Then 次のとおり、"03/28"の未完了のやることリストがある:
      | タイトル                                         |
      | ハローワークで失業認定申告書を提出する           |
      | 雇用保険受給資格者証を入手する                   |

    Then 次のとおり、完了分のやることリストがある:
      | タイトル                                         |
      | 雇用保険の失業等給付受給資格者のしおりを入手する |
      | 雇用保険受給資格者証を入手する（仮）             |

    When チェックボックス"雇用保険受給資格者証を入手する"をクリックする
    Then ページヘッダーに"雇用保険受給資格者証について教えてください。"とある
    And ページ本文に"仮である記載やしるしがありますか？"とない
    And ページ本文に"離職理由の番号"とある
    And ページ本文に"交付の日付"とある

    When セレクトボックス"離職理由の番号"の"34"を選ぶ
    And カレンダー"交付の日付"に"2023/03/29"と入力する
    And ボタン"完了にする"をクリックする

    Then ページ本文に"初回の給付金振込予定日は"とある
    And ページ本文に"04/05頃"とある
    And トースト"完了にしました。"がある

    Then 次のとおり、"03/15"の未完了のやることリストがある:
      | タイトル                                         |
      | ハローワークで雇用保険説明会に出席する           |

    Then 次のとおり、"03/28"の未完了のやることリストがある:
      | タイトル                                         |
      | ハローワークで失業認定申告書を提出する           |

    Then 次のとおり、完了分のやることリストがある:
      | タイトル                                         |
      | 雇用保険の失業等給付受給資格者のしおりを入手する |
      | 雇用保険受給資格者証を入手する（仮）             |
      | 雇用保険受給資格者証を入手する                   |
