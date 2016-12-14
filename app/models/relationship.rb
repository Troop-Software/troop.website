class Relationship < ApplicationRecord
  belongs_to :scout
  belongs_to :user
end