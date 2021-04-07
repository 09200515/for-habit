require 'rails_helper'

RSpec.describe "目標登録", type: :system do
  before do
    @user = FactoryBot.create(:user)
    @objective_big_area = Faker::Lorem.sentence
    @objective_text = Faker::Lorem.sentence
    @objective_small_step1 = Faker::Lorem.sentence
    @objective_small_step2 = Faker::Lorem.sentence
    @objective_small_step3 = Faker::Lorem.sentence
    @objective_small_step4 = Faker::Lorem.sentence
    @objective_small_step5 = Faker::Lorem.sentence
    @objective_if_then1 = Faker::Lorem.sentence
    @objective_if_then2 = Faker::Lorem.sentence
    @objective_if_then2 = Faker::Lorem.sentence
  end

  context '目標登録ができる時' do
    it 'ログインしたユーザーは目標登録できる' do
      # ログインする
      visit new_user_session_path
      fill_in 'E-mail:', with: @user.email
      fill_in 'Password:', with: @user.password
      find('input[name="commit"]').click
      # ログイン後、マイページに移動したことを確認する
      expect(current_path).to eq(user_path(@user.id))
      # 新しく目標を設定するリンクがあることを確認する
      expect(page).to have_content('新しく目標を設定する')
      # 登録ページに移動する
      visit step1_objectives_path
      # step1フォームに情報を入力する
      fill_in '習慣化する目標を決めましょう', with: @objective_big_area
      fill_in '設定した目標について理由を記入しましょう', with: @objective_text
      # Nextボタンを押すとstep2ページへ移動する
      find('input[name="commit"]').click
      expect(current_path).to eq('/objectives/step2')
      # step2フォームに情報を入力する
      fill_in 'Small Step1', with: @objective_small_step1
      fill_in 'Small Step2', with: @objective_small_step2
      fill_in 'Small Step3', with: @objective_small_step3
      fill_in 'Small Step4', with: @objective_small_step4
      fill_in 'Small Step5', with: @objective_small_step5
      # Nextボタンを押すとstep3ページに移動する
      find('input[name="commit"]').click
      expect(current_path).to eq('/objectives/step3')
      # step3フォームに情報を入力する
      fill_in 'きっかけ１', with: @objective_if_then1
      fill_in 'きっかけ２', with: @objective_if_then2
      fill_in 'きっかけ３', with: @objective_if_then3
      # 送信ボタンを押すとObjectiveモデルのカウントが１上がることを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { Objective.count }.by(1)
      # ユーザーページに遷移することを確認する
      expect(current_path).to eq(user_path(@user.id))
      # ユーザーページには登録した目標が存在することを確認する(@objective_big_area, @objective_text)
      expect(page).to have_content(@objective_big_area)
      expect(page).to have_content(@objective_text)
    end
  end

  context '目標登録できない時' do
    it 'ログインしていないとマイページに移動できない' do
      # トップページに遷移する
      visit root_path
      # マイページへのリンクがない
      expect(page).to have_no_content('マイページ')
    end

    it 'ログインし、誤った情報を入力すると登録できず、step1ページに遷移する' do
      # ログインする
      visit new_user_session_path
      fill_in 'E-mail:', with: @user.email
      fill_in 'Password:', with: @user.password
      find('input[name="commit"]').click
      # ログイン後、マイページに移動したことを確認する
      expect(current_path).to eq(user_path(@user.id))
      # 新しく目標を設定するリンクがあることを確認する
      expect(page).to have_content('新しく目標を設定する')
      # 登録ページに移動する
      visit step1_objectives_path
      # step1フォームに情報を入力する
      fill_in '習慣化する目標を決めましょう', with: ""
      fill_in '設定した目標について理由を記入しましょう', with: ""
      # Nextボタンを押すとstep2ページへ移動する
      find('input[name="commit"]').click
      expect(current_path).to eq('/objectives/step2')
      # step2フォームに情報を入力する
      fill_in 'Small Step1', with: ""
      fill_in 'Small Step2', with: ""
      fill_in 'Small Step3', with: ""
      fill_in 'Small Step4', with: ""
      fill_in 'Small Step5', with: ""
      # Nextボタンを押すとstep3ページに移動する
      find('input[name="commit"]').click
      expect(current_path).to eq('/objectives/step3')
      # step3フォームに情報を入力する
      fill_in 'きっかけ１', with: ""
      fill_in 'きっかけ２', with: ""
      fill_in 'きっかけ３', with: ""
      # 送信ボタンを押すとObjectiveモデルのカウントが上がらないことを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { Objective.count }.by(0)
      # step1ページに戻されることを確認する
      expect(current_path).to eq("/objectives")
    end
  end
end


RSpec.describe '目標編集', type: :system do
  before do
    @objective1 = FactoryBot.create(:objective)
    @objective2 = FactoryBot.create(:objective)
  end
  context '目標編集ができるとき' do
    it 'ログインしたユーザーは自分が設定した目標の編集ができる' do
      # 目標1を投稿したユーザーでログインする
      visit new_user_session_path
      fill_in 'E-mail:', with: @objective1.user.email
      fill_in 'Password:', with: @objective1.user.password
      find('input[name="commit"]').click
      # 目標１を投稿したユーザーのマイページに移動したことを確認する
      expect(current_path).to eq(user_path(@objective1.user.id))
      # 目標１の詳細に移動するリンクがあることを確認する
      expect(page).to have_content(@objective1.big_area)
      # 目標１の詳細ページに移動する
      visit objective_path(@objective1.id)
      # 目標1に「編集」ボタンがあることを確認する
      expect(page).to have_content('目標を編集する')
      # 編集ページへ遷移する
      visit edit_objective_path(@objective1.id)
      # すでに投稿済みの内容がフォームに入っていることを確認する
      expect(
        find('#objective_big_area').value
      ).to eq(@objective1.big_area)
      expect(
        find('#objective_text').value
      ).to eq(@objective1.text)
      expect(
        find('#objective_small_step1').value
      ).to eq(@objective1.small_step1)
      expect(
        find('#objective_small_step2').value
      ).to eq(@objective1.small_step2)
      expect(
        find('#objective_small_step3').value
      ).to eq(@objective1.small_step3)
      expect(
        find('#objective_small_step4').value
      ).to eq(@objective1.small_step4)
      expect(
        find('#objective_small_step5').value
      ).to eq(@objective1.small_step5)
      expect(
        find('#objective_if_then1').value
      ).to eq(@objective1.if_then1)
      expect(
        find('#objective_if_then2').value
      ).to eq(@objective1.if_then2)
      expect(
        find('#objective_if_then3').value
      ).to eq(@objective1.if_then3)
      # 投稿内容を編集する
      fill_in '習慣化する目標', with: "#{@objective1.big_area}+編集したテキスト"
      fill_in '設定理由', with: "#{@objective1.text}+編集したテキスト"
      fill_in 'Small Step1', with: "#{@objective1.small_step1}+編集したテキスト"
      fill_in 'Small Step2', with: "#{@objective1.small_step2}+編集したテキスト"
      fill_in 'Small Step3', with: "#{@objective1.small_step3}+編集したテキスト"
      fill_in 'Small Step4', with: "#{@objective1.small_step4}+編集したテキスト"
      fill_in 'Small Step5', with: "#{@objective1.small_step5}+編集したテキスト"
      fill_in 'きっかけ１', with: "#{@objective1.if_then1}+編集したテキスト"
      fill_in 'きっかけ２', with: "#{@objective1.if_then2}+編集したテキスト"
      fill_in 'きっかけ３', with: "#{@objective1.if_then3}+編集したテキスト"
      # 編集してもObjectiveモデルのカウントは変わらないことを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { Objective.count }.by(0)
      # 目標詳細ページに遷移したことを確認する
      expect(current_path).to eq(objective_path(@objective1.id))
      # トップページには先ほど変更した内容の目標が存在することを確認する（テキスト）
      expect(page).to have_content("#{@objective1.big_area}+編集したテキスト")
      expect(page).to have_content("#{@objective1.text}+編集したテキスト")
      expect(page).to have_content("#{@objective1.small_step1}+編集したテキスト")
      expect(page).to have_content("#{@objective1.small_step2}+編集したテキスト")
      expect(page).to have_content("#{@objective1.small_step3}+編集したテキスト")
      expect(page).to have_content("#{@objective1.small_step4}+編集したテキスト")
      expect(page).to have_content("#{@objective1.small_step5}+編集したテキスト")
      expect(page).to have_content("#{@objective1.if_then1}+編集したテキスト")
      expect(page).to have_content("#{@objective1.if_then2}+編集したテキスト")
      expect(page).to have_content("#{@objective1.if_then3}+編集したテキスト")
    end
  end
end

RSpec.describe '目標削除', type: :system do
  before do
    @objective1 = FactoryBot.create(:objective)
  end
  context '目標削除ができるとき' do
    it 'ログインしたユーザーは自らが登録した目標の削除ができる' do
      # 目標1を投稿したユーザーでログインする
      visit new_user_session_path
      fill_in 'E-mail:', with: @objective1.user.email
      fill_in 'Password:', with: @objective1.user.password
      find('input[name="commit"]').click
      # 目標１を投稿したユーザーのマイページに移動したことを確認する
      expect(current_path).to eq(user_path(@objective1.user.id))
      # 目標１の詳細に移動するリンクがあることを確認する
      expect(page).to have_content(@objective1.big_area)
      # 目標１の詳細ページに移動する
      visit objective_path(@objective1.id)
      # 目標1に「削除」ボタンがあることを確認する
      expect(page).to have_content('目標を削除する')
      # 削除ボタンを押すと、「本当に削除してもよろしいですか？」と表示されたダイアログが表示され、OKボタンを押すと、削除が完了しましたとの記述が表示され、レコードの数が１減ることを確認する
      expect{
        click_on :delete_btn
        expect(page.accept_confirm).to eq "本当に削除してもよろしいですか？"
        expect(page).to have_content "削除が完了しました"
      }.to change { Objective.count }.by(-1)
      # マイページに遷移したことを確認する
      expect(current_path).to eq(user_path(@objective1.user.id))
      # トップページにはツイート1の内容が存在しないことを確認する
      expect(page).to have_no_content("#{@objective1.big_area}")
    end
  end

end