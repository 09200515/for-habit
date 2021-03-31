require 'rails_helper'

RSpec.describe "記録", type: :system do
  before do
    @user = FactoryBot.create(:user)
    @objective = FactoryBot.create(:objective)
    sleep 0.3
    @record.date = "2021-3-20"
    @record.data = 100
    @record.unit_id = 2
    @record.inpression = Faker::Lorem.sentence
  end

  context "記録登録できる時" do
    
  end
end

RSpec.discribe "記録編集", type: :system do
  before do
    
  end

  context "記録の編集ができる時" do
    
  end

  context "記録の編集ができない時" do
    
  end
end

RSpec.discribe "記録削除" do
  before do
    
  end
  context "記録削除できる時" do
    
  end
  context "記録削除できない時" do
    
  end
end




