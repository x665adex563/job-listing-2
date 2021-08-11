class Job < ApplicationRecord

  validates :title, presence: true
  validates :company, presence: true
  validates :wage_upper_bound, presence: true
  validates :wage_lower_bound, presence: true
  validates :wage_lower_bound, numericality: { greater_than: 0}

  scope :published, -> { where(is_hidden: false)}
  scope :recent, -> { order('created_at DESC')}
  scope :lower_salary, -> { order('wage_lower_bound DESC') }
  scope :upper_salary, -> { order('wage_upper_bound DESC') }

  has_many :resumes

  def self.search(search)
    		if search
      		#where("title LIKE ?", "%#{search}%")
    			where("title LIKE :search OR description LIKE :search", search: "%#{search}%")
    		else
      		all
      	end
  end

  def publish!
    self.is_hidden = false
    self.save
  end

  def hide!
    self.is_hidden = true
    self.save
  end


end
