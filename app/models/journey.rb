class Journey < ActiveRecord::Base
  has_and_belongs_to_many :users
  default_scope order('date')
  validates_presence_of :user_ids
  validates_presence_of :description
  
  def total_miles
    if end_mileage and start_mileage
       end_mileage - start_mileage
    else 
       0
    end
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
      'complete' => complete?,
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
  
  def complete?
    !end_mileage.nil?
  end
  
  def validate
     errors[:mileage] << "You have a negative mileage" if invalid_mileage
  end
  
  def invalid_mileage
    !end_mileage.nil? and end_mileage < start_mileage
  end
  
end
