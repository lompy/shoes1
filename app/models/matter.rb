class Matter < ActiveRecord::Base
  has_and_belongs_to_many :partypes
  validates :name, presence: true

  include HasCrudableView
  has_collections :partypes
  has_fields :name
end
