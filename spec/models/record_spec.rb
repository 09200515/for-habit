require 'rails_helper'

RSpec.describe Record, type: :model do
  before do
    @record = FactoryBot.build(:record)
  end

  describe "レコード登録" do
    context "保存できる時" do
      it "全ての情報が正しく入力されている時保存できる" do
        expect(@record).to be_valid
      end

      it "inpressionが空でも登録できる" do
        @record.inpression = ""
        expect(@record).to be_valid
      end
    end

    context "保存できない時" do
      it "dateが空だと登録できない" do
        @record.date = nil
        @record.valid?
        expect(@record.errors.full_messages).to include "Dateを入力してください"
      end

      it "dataが空だと登録できない" do
        @record.data = nil
        @record.valid?
        expect(@record.errors.full_messages).to include "Dataを入力してください"
      end

      it "unit_idが0の時登録できない" do
        @record.unit_id = 0
        @record.valid?
        expect(@record.errors.full_messages).to include "Unitselect"
      end

      it "dataが文字列の時は登録できない" do
        @record.data = "文字列"
        @record.valid?
        expect(@record.errors.full_messages).to include "Dataは数値で入力してください"
      end

      it "dateの年が空だと登録できない" do
        @record.date = "/3/3"
        @record.valid?
        expect(@record.errors.full_messages).to include "Dateを入力してください"
      end

      it "dateの月が体と登録できない" do
        @record.date = "2021//2"
        @record.valid?
        expect(@record.errors.full_messages).to include "Dateを入力してください"
      end

      it "dateの日が空だと登録できない" do
        @record.date = "2021/2/"
        @record.valid?
        expect(@record.errors.full_messages).to include "Dateを入力してください"
      end
    end
  end
end
