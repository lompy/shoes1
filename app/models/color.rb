class Color < ActiveRecord::Base
  has_many :shoes
  validates :name, presence: true

  include HasCrudableView
  has_collections :shoes
  has_fields :name
end
