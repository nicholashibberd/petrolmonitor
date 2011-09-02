class Group < ActiveRecord::Base
  has_many :users
  has_many :payments
  has_many :journeys
  
  before_create :generate_group_token
  def generate_group_token(length=8)
    alphanumerics = ('a'..'z').to_a.concat(('A'..'Z').to_a.concat(('0'..'9').to_a))
    unless Group.find_by_group_token(alphanumerics)
      self.group_token = alphanumerics.sort_by{rand}.to_s[0..length]
    else
      generate_group_token
    end
  end
  
  def total_miles
    journey_miles = journeys.map {|journey| journey.total_miles}
    journey_miles.inject {|a, b| a + b}
  end

  def total_expenditure
    payment_amounts = payments.map {|payment| BigDecimal(payment.amount)}
    payment_amounts.inject {|a, b| a + b}
  end
  
  def cost_per_mile
    total_expenditure / total_miles
  end
  
  def current_mileage
    unless journeys.empty?
      journeys.last.end_mileage
    end
  end
  
  def history
    history_array = payments.map {|payment| payment.payment_summary} + journeys.map {|journey| journey.journey_summary}
    history_array.sort {|a, b| b["date"] <=> a["date"]}
  end
  
end
