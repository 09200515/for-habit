# for-Habit

## アプリケーション概要
ユーザーは自身が習慣化したいことや、達成したい目標を設定し、毎日実行した時間や量を記録することができる。
また、カウントダウンタイマーを利用することで、時間を設定し目標に向けての行動している時間を計測することができる。
他のユーザーが実行した内容を一覧で確認することができ、他ユーザーの詳細ページでどの程度実行しているのかを確認することができる。

## URL
https://for-habit.herokuapp.com/

### テスト用アカウント
E-mail: a@a
Password: aaaaa1

## ペルソナ
ターゲット：年齢や性別、職業は問わず、ダイエットをして痩せたいけど続かない人や、筋トレを習慣化したいけどうまくいかない人など、なにかを頑張りたい気持ち・思いがあるのにうまく続けられない人をターゲットとする。もうすでに習慣化していることがあるが、記録を残すことに特化した便利なアプリを探している人をターゲットに設定する。

## 目指した課題解決
何かを続けることが苦手な人に、継続するための手助けができるアプリケーションを目指した。
運動を習慣化して体重を落としたい人や、筋トレ・読書を習慣化したいが続かない人のために、実行結果を記録、可視化して他ユーザーと共有することでモチベーションの向上や継続する力を身に付けさせることが狙いである。

## 要件定義
- サインイン・ログインページに遷移するボタンがある。
- ログアウトできるボタンがある。
- 新規投稿できるボタンがある。
- 編集・削除ができるボタンがある。
- 投稿の詳細ページに遷移できるボタンがある。
- 他のユーザーの投稿を一覧でみれるページへ遷移するボタンがある。
- タイマー機能を導入して、計測した時間をそのままデータとして保存する。
- 保存したデータをグラフとして表示する。
- 単位は時間の他にも自分で決められるようにする。

表示
- 結果をグラフ化して見える化をする。グラフは横スクロールすることで複数のグラフを確認することができる。
- 記録一覧を縦スクロールで見れるようにする。
- 目標設定をする際にはウィザード形式を採用する。
- if_thenプランニングを採用する。
- 他ユーザーの詳細ページに移動することができる。


# データベース設計

## usersテーブル

| Column             | Type    | Options                   |
| ------------------ | ------- | ------------------------- |
| nickname           | string  | null: false               |
| email              | string  | null: false, unique: true |
| encrypted_password | string  | null: false               |

### Association
- has_many :objectives
- has_many :records


## objectivesテーブル

| Column             | Type       | Options                   |
| ------------------ | ---------- | ------------------------- |
| big_area           | string     | null: false               |
| text               | text       | null: false               |
| user               | references | foreign_key: true         |
| small_step1        | text       | null: false               |
| small_step2        | text       | null: false               |
| small_step3        | text       | null: false               |
| small_step4        | text       |                           |
| small_step5        | text       |                           |
| if_then1           | text       | null: false               |
| if_then2           | text       | null: false               |
| if_then3           | text       |                           |

### Association
- belongs_to :user
- has_many :records


## recordsテーブル

| Column             | Type       | Options                   |
| ------------------ | ---------- | ------------------------- |
| date               | date       | null: false               |
| data               | integer    | null: false               |
| unit_id            | integer    | null: false               |
| inpression         | text       |                           |
| user               | references | foreign_key: true         |
| objecitve          | references | foreign_key: true         |

### Association
- belongs_to :user
- belongs_to :objective

