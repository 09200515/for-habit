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




