class MileageValidator < ActiveModel::Validator
  def validate(journey)
    if journey.end_mileage < journey.start_mileage
      journey.errors[:base] << "You have a negative mileage!"
    end
  end
end