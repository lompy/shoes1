class PartsController < ApplicationController
  include Common

  private
  def set_model_and_relation
    @model = Part
    @relation = Part.where(shoe_id: params[:shoe_id])
  end
end
