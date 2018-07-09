class Project < ApplicationRecord
	has_many :steps, -> { order(order: :asc) }, dependent: :destroy
	accepts_nested_attributes_for :steps, allow_destroy: true
end
