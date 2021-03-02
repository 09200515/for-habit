# for-habitのER図

## ペルソナ
年齢と性別: 20~40歳 社会人、主婦など 男女問わず

職業: ある程度の時間の融通がきく人。定時前後で退勤し、一日にフリーな時間が３時間程度確保できそうな人。

趣味: 音楽や映画などの聞くことや見ることに時間を使うような趣味より、運動や読書などの自分の＋αになるようなことをしたいと思っている人をターゲットにする。

ターゲット：ダイエットをして痩せたいけど続かない人や、筋トレを習慣化したいけどうまくいかない人など、なにかを頑張りたい気持ち・思いがあるのにうまく続けられないひと。もうすでに習慣化していることがあるが、記録を残すことに特化した便利なアプリを探している人をターゲットに設定する。


## 要件定義
サインイン・ログインページに遷移するボタンがある。
ログアウトできるボタンがある。
新規投稿できるボタンがある。
編集・削除ができるボタンがある。
投稿の詳細ページに遷移できるボタンがある。
他のユーザーの投稿を一覧でみれるページへ遷移するボタンがある。
タイマー機能を導入して、計測した時間をそのままデータとして保存する。
保存したデータをグラフとして表示する。
単位は時間の他にも自分で決められるようにする。
タグ機能（ジャンルなどを設定する。）
タグやジャンルを投稿に設定する。
タグやジャンルで一覧ページに表示する投稿を変更することができる。
ジャンル問わずの一覧表示もできるようになる。
カレンダー機能も導入する。（横スクロールで見れるようにする。）
コメント機能をつける。
いいね機能もつける。
自分の投稿を見せない機能をつける。(鍵アカウントのようなもの)

表示
結果をグラフ化して見える化をする。
投稿一覧を立てスクロールで見れるようにする。
自分の投稿にデータ、コメント、いいね、タグ（ジャンル）を表示する。
目標設定をする際にはウィザード形式を採用する。
if_thenプランニングを採用する。
写真も投稿できるようにする。
投稿者のコメントを表示できるようにする。


## usersテーブル

| Column             | Type    | Options                   |
| ------------------ | ------- | ------------------------- |
| nickname           | string  | null: false               |
| email              | string  | null: false, unique: true |
| encrypted_password | string  | null: false               |

### Association
- has_many :objectives
- has_many :records
- has_many :comments


## objectivesテーブル

| Column             | Type      | Options                   |
| ------------------ | --------- | ------------------------- |
| big_area           | string    | null: false               |
| text               | text      | null: false               |
| user               | reference | foreign_key: true         |
| small_step1        | text      | null: false               |
| small_step2        | text      | null: false               |
| small_step3        | text      | null: false               |
| small_step4        | text      |                           |
| small_step5        | text      |                           |
| if_then1           | text      | null: false               |
| if_then2           | text      | null: false               |
| if_then3           | text      |                           |

### Association
- belongs_to :user
- has_many :records


## recordsテーブル

| Column             | Type      | Options                   |
| ------------------ | --------- | ------------------------- |
| record             | integer   | null: false               |
| unit               | integer   | null: false               |
| text               | text      |                           |
| user               | reference | foreign_key: true         |
| objecitve          | reference | foreign_key: true         |

### Association
- belongs_to :user
- belongs_to :objective

## commentsテーブル

| Column             | Type      | Options                   |
| ------------------ | --------- | ------------------------- |
| comment            | text      | null: false               |
| user               | reference | foreign_key: true         |
| recode             | reference | foreign_key: true         |