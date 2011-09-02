class User < ActiveRecord::Base
  belongs_to :group
  has_and_belongs_to_many :payments
  has_and_belongs_to_many :journeys  
  attr_accessor :password
  attr_accessible :name, :email, :password, :password_confirmation
  
  EmailRegex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  
  validates_format_of	:email, :with => EmailRegex
  validates_uniqueness_of :email, :case_sensitive => false
  validates_confirmation_of :password
  
  validates_presence_of :name, :on => :create
  validates_presence_of :password, :on => :create
  validates_length_of	:password, :within => 6..40, :on => :create
  
  before_save :encrypt_password
  
  def assign_group(group)
    self.group_id = group.id
    self.save
  end
    
  def total_miles
    journeys.map(&:total_miles).inject(0) {|a,b| a + b}
  end
  
  def total_liability
    user_payments = group.payments.map {|payment| payment.liability_for_user(self)}
    user_payments.inject(0) {|a,b| a + b}
  end
  
  def total_contribution
    payment_amounts = payments.map {|payment| payment.contribution_for_user(self)}
    payment_amounts.inject {|a, b| a + b}
  end
  
  def balance
    total_contribution - total_liability
  end
  
  def has_password?(submitted_password)
    encrypted_password == encrypt(submitted_password)
  end
  
  def self.authenticate(email, submitted_password)
    user = User.find_by_email(email)
     return nil if user.nil?
     return user if user.has_password?(submitted_password)
  end

  def remember_me!
    self.remember_token = encrypt("#{salt}--#{id}")
    save(:validate => false)
  end
  
  def history
    history_array = payments.map {|payment| payment.payment_summary} + journeys.map {|journey| journey.journey_summary}
    history_array.sort {|a, b| b["date"] <=> a["date"]}
  end
      
  private
  
  def encrypt_password
    unless password.nil?
      self.salt = make_salt
      self.encrypted_password = encrypt(password)
    end
  end
  
  def encrypt(string) 
    secure_hash("#{salt}#{string}")
  end
  
  def make_salt
    secure_hash("#{Time.now.utc}#{password}")
  end
  
  def secure_hash(string)
    Digest::SHA2.hexdigest(string)
  end    
  
end
