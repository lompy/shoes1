class Partype < ActiveRecord::Base
  has_and_belongs_to_many :matters
  has_many :parts
  validates :name, presence: true

  include HasCrudableView
  has_collections :parts, editable: [:matters]
  has_fields :name
end
