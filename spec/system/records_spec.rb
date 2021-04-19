require 'rails_helper'

RSpec.describe "記録", type: :system do
  before do
    @user = FactoryBot.create(:user)
    @objective = FactoryBot.create(:objective)
    sleep 0.3
    @record_date = "2021-3-20"
    @record_data = 100
    @record_unit_id = 2
    @record_inpression = Faker::Lorem.sentence
  end

  context "記録登録できる時" do
    it 'ログイン状態のユーザーは目標から記録を登録することができる' do
      # 目標を登録したユーザーでログインする
      visit new_user_session_path
      fill_in 'E-mail:', with: @objective.user.email
      fill_in 'Password:', with: @objective.user.password
      find('input[name="commit"]').click
      # ログイン後、マイページに移動したことを確認する
      expect(current_path).to eq(user_path(@objective.user.id))
      # 目標詳細へのリンクがあることを確認する
      expect(page).to have_content(@objective.big_area)
      # 目標詳細へ移動する
      visit objective_path(@objective.id)
      # 記録をするリンクがあることを確認する
      expect(page).to have_content('記録をする')
      # 登録ページに移動する
      visit new_objective_record_path(@objective.id)
      # 記録を入力する
      select '2021', from: 'record[date(1i)]'
      select '1', from: 'record[date(2i)]'
      select '1', from: 'record[date(3i)]'
      fill_in 'record[data]', with: @record_data
      select '分', from: 'record[unit_id]'
      fill_in 'record[inpression]', with: @record_inpression
      # 登録ボタンを押すとRecordモデルのカウントが１上がることを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { Record.count }.by(1)
      # 目標詳細ページに移動することを確認する
      expect(current_path).to eq(objective_path(@objective.id))
      # 目標詳細ページでは登録した記録が存在することを確認する
      expect(page).to have_content(@record＿data)
    end
  end

  context "記録登録できない時" do
    it "ログイン状態のユーザーは記録ページでフォームを空のまま送信すると登録できずリダイレクトする" do
      # 目標を登録したユーザーでログインする
      visit new_user_session_path
      fill_in 'E-mail:', with: @objective.user.email
      fill_in 'Password:', with: @objective.user.password
      find('input[name="commit"]').click
      # ログイン後、マイページに移動したことを確認する
      expect(current_path).to eq(user_path(@objective.user.id))
      # 目標詳細へのリンクがあることを確認する
      expect(page).to have_content(@objective.big_area)
      # 目標詳細へ移動する
      visit objective_path(@objective.id)
      # 記録をするリンクがあることを確認する
      expect(page).to have_content('記録をする')
      # 記録ページに移動する
      visit new_objective_record_path(@objective.id)
      # フォームは空のまま送信ボタンを押し、Recordモデルのカウントが上がらないことを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { Record.count }.by(0)
      # ページ遷移せず、記録を登録するページに戻る
      expect(current_path).to eq("/objectives/#{@objective.id}/records")
    end
  end
end

RSpec.describe "記録編集", type: :system do
  before do
    @record = FactoryBot.create(:record)
  end

  context "記録の編集ができる時" do
    it 'ログインしたユーザーは自分が登録した記録の編集ができる' do
      # 記録を登録したユーザーでログインする
      # 記録を登録したユーザーのマイページに移動したことを確認する
      # 記録に関連する目標に移動するリンクがあることを確認する
      # 目標詳細ページに移動する
      # 目標詳細ページに記録があり、編集ボタンがあることを確認する
      # 編集ページへ移動する
      # すでに投稿済みの内容がフォームに入っていることを確認する
      # 投稿内容を編集する
      # 送信ボタンを押してもRecordモデルのカウントが変わらないことを確認する
      # 目標詳細ページに遷移したことを確認する
      # 目標詳細ページの記録には変更した内容が反映されていることを確認する
    end
  end

  context "記録の編集ができない時" do
    it 'ログインしていないユーザーは記録編集ページに移動できない' do
      # トップページに遷移する
      # 記録に編集ボタンが存在しないことを確認する
    end
  end
end

RSpec.describe "記録削除" do
  before do
    @record = FactoryBot.create(:record)
  end
  context "記録削除できる時" do
    it '記録を投稿したユーザーは記録を削除することができる' do
      # 記録を登録したユーザーでログインする
      # マイページに移動したことを確認する
      # 記録と関連する目標のリンクがあることを確認する
      # 目標詳細ページへ移動する
      # 記録があること確認し、削除ボタンかあることを確認する
      # 削除ボタンを押すと、「本当に削除してもよろしいですか？」と表示されたダイアログが表示され、OKボタンを押すと、削除が完了しましたとの記述が表示され、レコードの数が１減ることを確認する
      # 目標詳細ページに移動したことを確認する
      # 記録が存在しないことを確認する
    end
  end
  context "記録削除できない時" do
    it 'ログインしていないユーザーは記録削除のボタンが存在しない' do
      # トップページに遷移する
      # 記録に削除ボタンがないことを確認する
    end
  end
end




