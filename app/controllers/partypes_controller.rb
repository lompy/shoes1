class PartypesController < ApplicationController
  include Common

  def select
    @records = Partype.all
    @select = { part_id: params[:part_id], shoe_id: params[:shoe_id] }
    @do_not_show_add_link = true
    render 'crudable/index'
  end
end
