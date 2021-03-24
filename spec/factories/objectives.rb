FactoryBot.define do
  factory :objective do
    big_area { "読書" }
    text { "テキスト" }
    small_step1 { "一日１ぺージ" }
    small_step2 { "一週間で１冊" }
    small_step3 { "１ヶ月で３冊" }
    small_step4 { "半年で２０冊" }
    small_step5 { "１年で４０冊" }
    if_then1 { "椅子に座ったら本を開く" }
    if_then2 { "朝起きたら１０ページ" }
    if_then3 { "寝る前に１０ページ" }

    association :user
    
  end
end
