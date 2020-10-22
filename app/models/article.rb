class Article < ApplicationRecord
    # Ensure Articles without a title or description are not saved to the DB
    validates :title, presence: true, length: { minimum: 6, maximum: 100}
    validates :description, presence: true, length: { minimum: 10, maximum: 300}
end