class Part < ActiveRecord::Base
  belongs_to :shoe
  belongs_to :matter
  belongs_to :partype
  validates :shoe, :partype, presence: true

  include HasCrudableView
  has_fields selectable: [:partype, :matter], invisible: [:shoe]

  def name
    self.shoe.name + "'s " +
      (self.partype ? partype.name : "new part") +
      ": " +
      (self.matter ? matter.name : "no matter")
  end
end
