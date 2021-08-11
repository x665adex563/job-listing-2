class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def admin?
    is_admin
  end

  has_many :resumes

  def has_applied?(job)
    applied_jobs.include?(job)
  end

  def apply!(job)
    applied_jobs << job
  end
end
