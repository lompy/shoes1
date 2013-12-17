class MattersController < ApplicationController
  include Common

  def select
    @relation = Matter.joins(:partypes).where('partypes.id' => params[:partype_id])
    @records = @relation.to_a
    @select = { part_id: params[:part_id], partype_id: params[:partype_id], shoe_id: params[:shoe_id] }
    @do_not_show_add_link = true
    render 'crudable/index'
  end
end
