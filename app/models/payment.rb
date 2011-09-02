class Payment < ActiveRecord::Base
  belongs_to :group
  has_and_belongs_to_many :users
  default_scope order('date')

  def amount_parse=(amount)
    if amount.include?(".")
      self.amount = amount.gsub(".", "")
    else
      self.amount = BigDecimal("#{amount}") * BigDecimal('100')
    end
  end
  
  def amount_parse
    self.amount
  end
  
  def journeys
    #group.journeys.find(:all, :conditions => {:date => (Date.today - 100)..(Date.today - 100)})
    group.journeys.where(['date >= ? AND date <= ?', date, next_payment ? next_payment.date : Date.today])
  end
  
  def total_miles
    miles_before_next_payment.nil? ? total_miles_from_journeys : miles_before_next_payment
  end
  
  def total_miles_from_journeys
    journey_miles = journeys.map {|journey| journey.total_miles}
    journey_miles.inject(0) {|a, b| a + b}
  end
  
  def miles_since_last_payment
    unless previous_payment.nil?
      Integer(mileage) - Integer(previous_payment.mileage)
    end
  end
  
  def miles_before_next_payment
    unless next_payment.nil?
      Integer(next_payment.mileage) - Integer(mileage)
    end    
  end
  
  def cost_per_mile
    total_miles == 0 ? "No journeys" : BigDecimal(amount) / total_miles
  end
  
  def next_payment
    subsequent_payments = group.payments.select {|payment| payment.date >= date}
    subsequent_payments.find {|payment| payment.id != id}
  end

  def previous_payment
    preceeding_payments = group.payments.select {|payment| payment.date <= date && payment.id != id }
    preceeding_payments.last
  end
  
  def miles_for_user(user)
    journeys_for_user = journeys.select {|journey| journey.users.include?(user)}
    journeys_for_user.map(&:miles_per_user).inject(0) {|a,b| a + b}
  end
  
  def liability_for_user(user)
    miles_for_user(user) * cost_per_mile
  end
  
  def contribution_for_user(user)
    BigDecimal(amount) / users.size
  end
  
  def payment_summary
    {
      'summary_type' => 'payment',
      'date' => date,
      'amount' => amount,
      'contributors' => users_to_string,
      'id' => id
    }
  end
  
  def users_to_string
    if users.size == 1
      users.first.name
    else  
      user_names = users.map(&:name)
      users_except_last = user_names.first user_names.size - 1
      last_user = user_names.last
      [users_except_last.join(', '), last_user].join(' and ')
    end
  end

end
