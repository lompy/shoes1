class ColorsController < ApplicationController
  include Common

  def select
    @records = Color.all
    @select = { shoe_id: params[:shoe_id] }
    @do_not_show_add_link = true
    render 'crudable/index'
  end
end
