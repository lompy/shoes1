class PartypeMattersController < ApplicationController
  include Common

  def index
    @records = @relation.all
    @select = { partype_id: params[:partype_id], partype_matters: true, remove_matter: true }
    render file: "crudable/index"
  end

  def new
    @records = Matter.joins(
      'left join matters_partypes on matters_partypes.matter_id = matters.id'
    ).where('matters_partypes.partype_id <> ? or matters_partypes.partype_id is null', params[:partype_id]).to_a
    @select = { partype_id: params[:partype_id], partype_matters: true }
    @do_not_show_add_link = true
    render 'crudable/index'
  end

  def add
    @record = Matter.find_by_id(params[:id])
    partype = Partype.find_by_id(params[:partype_id])
    partype.matters << @record
    redirect_to partype_matters_path(params[:partype_id])
  end

  def destroy
    partype = Partype.find_by_id(params[:partype_id])
    partype.matters.delete(@record)
    redirect_to partype_matters_path(params[:partype_id])
  end

  private

  def set_model_and_relation
    @model = Matter
    @relation = Matter.joins(:partypes).where('partypes.id' => params[:partype_id])
    @partype_id = params[:partype_id]
  end

end
