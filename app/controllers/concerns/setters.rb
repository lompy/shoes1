module Setters
  def set_model_and_relation
    @model = model_from_controller_name(controller_name)
    @relation = @model.all
  end

  def set_record
    @record = @relation.find(params[:id])
  end

  def record_params
    params.require(
      model_from_controller_name(controller_name).to_s.downcase.to_sym
    ).permit!
  end
end
