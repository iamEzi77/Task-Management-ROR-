class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         enum :role, { employee: 0, admin: 1 }

  has_many :projects

  def admin?
    role == 'admin'
  end

  def employee?
    role == 'employee'
  end
   
end
