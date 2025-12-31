class Todo < ApplicationRecord
  validates :title, length: { maximum: 100 }
end
