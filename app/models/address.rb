class Address < ApplicationRecord
  belongs_to :addressable, :polymorphic => true

  def full
    [line1, line2, city, state, zip].compact.join(', ')
  end
end