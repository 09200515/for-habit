require 'rails_helper'

RSpec.describe Objective, type: :model do
  before do
    @objective = FactoryBot.build(:objective)
  end

  describe "objective保存" do
    context "保存できる時" do
      it "全ての情報が正しく入力されている時保存できる" do
        expect(@objective).to be_valid
      end

      it "small_step4が空でも登録できる" do
        @objective.small_step4 = nil
        expect(@objective).to be_valid
      end

      it "small_step5が空でも登録できる" do
        @objective.small_step5 = nil
        expect(@objective).to be_valid
      end

      it "if_then3が空でも登録できる" do
        @objective.if_then3 = nil
        expect(@objective).to be_valid
      end
    end

    context "保存できない時" do
      it "big_areaが空の場合登録できない" do
        @objective.big_area = ""
        @objective.valid?
        expect(@objective.errors.full_messages).to include "Big areaを入力してください"
      end

      it "textが空の場合登録できない" do
        @objective.text = ""
        @objective.valid?
        expect(@objective.errors.full_messages).to include "Textを入力してください"
      end

      it "small_step1が空の場合登録できない" do
        @objective.small_step1 = ""
        @objective.valid?
        expect(@objective.errors.full_messages).to include "Small step1を入力してください"
      end

      it "small_step２が空の場合登録できない" do
        @objective.small_step2 = ""
        @objective.valid?
        expect(@objective.errors.full_messages).to include "Small step2を入力してください"
      end
      
      it "small_step3が空の場合登録できない" do
        @objective.small_step3 = ""
        @objective.valid?
        expect(@objective.errors.full_messages).to include "Small step3を入力してください"
      end

      it "if_then1が空の場合登録できない" do
        @objective.if_then1 = ""
        @objective.valid?
        expect(@objective.errors.full_messages).to include "If then1を入力してください"
      end

      it "if_then2が空の場合登録できない" do
        @objective.if_then2 = ""
        @objective.valid?
        expect(@objective.errors.full_messages).to include "If then2を入力してください"
      end
    end
  end
end
