class Objective < ApplicationRecord

  with_options presence: true do
    validates :big_area
    validates :text
    validates :small_step1
    validates :small_step2
    validates :small_step3
    validates :if_then1
    validates :if_then2
  end
  
  belongs_to :user

end
