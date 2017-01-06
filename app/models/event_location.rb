class EventLocation < ApplicationRecord
  enum type: [:camp_site, :camp_site_with_cabins, :high_adventure, :hiking, :tour, :other]

  belongs_to :event

  def address
    [street, city, state, zip].compact.join(', ')
  end

  def location
    [name, address].join(', ')
  end
end
