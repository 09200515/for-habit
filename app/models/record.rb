class Record < ApplicationRecord

  with_options presence: true do
    validates :date
    validates :data
    validates :unit
  end

  belongs_to :user
  belongs_to :objective


end
