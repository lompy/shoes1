class Shoe < ActiveRecord::Base
  belongs_to :color
  has_many :parts
  validates :name, presence: true

  include HasCrudableView
  has_collections editable: [:parts]
  has_fields :name, :size, selectable: [:color]
end
