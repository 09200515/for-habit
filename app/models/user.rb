class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

         def update_without_current_password(params, *options)
          params.delete(:current_password)
      
          if params[:password].blank? && params[:password_confirmation].blank?
            params.delete(:password)
            params.delete(:password_confirmation)
          end
      
          result = update_attributes(params, *options)
          clean_up_passwords
          result
        end

        
  validates :nickname, presence: true
  validates :password, presence: true, on: :create, format: { with: /([0-9].*[a-zA-Z]|[a-zA-Z].*[0-9])/ }
    
  has_many :objectives, dependent: :destroy
  has_many :records, dependent: :destroy
end
