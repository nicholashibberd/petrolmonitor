class Journey < ActiveRecord::Base
  has_and_belongs_to_many :users
  default_scope order('date')
  
  def total_miles
    end_mileage - start_mileage
  end
  
  def miles_per_user
    Float(total_miles) / users.size
  end
  
  def journey_summary
    {
      'summary_type' => 'journey',      
      'date' => date,
      'description' => description,
      'travellers' => users_to_string,
      'miles' => total_miles,
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
