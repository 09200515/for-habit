# for-habitのER図

## ペルソナ
年齢と性別: 20~40歳 社会人、主婦など 男女問わず

職業: ある程度の時間の融通がきく人。定時前後で退勤し、一日にフリーな時間が３時間程度確保できそうな人。

ターゲット：ダイエットをして痩せたいけど続かない人や、筋トレを習慣化したいけどうまくいかない人など、なにかを頑張りたい気持ち・思いがあるのにうまく続けられない人。もうすでに習慣化していることがあるが、記録を残すことに特化した便利なアプリを探している人をターゲットに設定する。


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
自分の投稿を見せない機能をつける。(鍵アカウントのようなもの)

表示
結果をグラフ化して見える化をする。
投稿一覧を立てスクロールで見れるようにする。
目標設定をする際にはウィザード形式を採用する。
if_thenプランニングを採用する。


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

