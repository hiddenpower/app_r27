class Client < ActiveRecord::Base
  attr_accessible :name, :email, :depto, :last_name, :phone, :status, :date

  before_save { |client| client.email = email.downcase }

  def status_enum
    all_status = {1 => 'Active', 0 => 'Pending', 2 => 'Banned'}
    all_status.map{|key, val| [val, key]}
  end

  validates :name, presence: true, length: { maximum: 20 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence:   true,
            format:     { with: VALID_EMAIL_REGEX }
  validates :depto, presence: true
  validates :last_name, presence: true
  validates :phone, presence: true, :numericality => {:only_integer => true}, length: { maximum: 10 }
  validates :status, presence: true

end