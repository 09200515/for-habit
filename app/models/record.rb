class Record < ApplicationRecord

  with_options presence: true do
    validates :date
    validates :data
    validates :unit_id, numericality: { other_than: 0, message: 'select' }
  end

  belongs_to :user
  belongs_to :objective


end
