class Project < ApplicationRecord
  enum project_type: { in_house: 0, external: 1, international: 2 }

  belongs_to :user
  has_many :contents

  validates :title, presence: true
  validates :project_type, presence: true
  validates :location, presence: true
  validates :thumbnail, presence: true
end
