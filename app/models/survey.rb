class Survey < ApplicationRecord
  belongs_to :student
  belongs_to :event
end