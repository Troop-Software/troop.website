class AdultVehicle < ApplicationRecord
  validates_uniqueness_of :adult_id, scope: [:vehicle_id], message: '- There is a record that matches this already.'
  
  belongs_to :adult
  belongs_to :vehicle
end