class ColorsController < ApplicationController
  include Common

  def select
    @records = Color.all
    @select = { shoe_id: params[:shoe_id] }
    render 'crudable/index'
  end
end
