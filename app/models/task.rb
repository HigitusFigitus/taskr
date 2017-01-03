class Task < ApplicationRecord
  validates :content, presence: true, length: { minimum: 4, maximum: 400 }
end