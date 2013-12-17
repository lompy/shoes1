module Crud
  def index
    @records = @relation.all
    render file: "crudable/index"
  end

  def show
    render file: "crudable/show"
  end

  def new
    @record = @relation.new
    set_selected
    render file: "crudable/new"
  end

  def edit
    set_selected
    render file: "crudable/edit"
  end

  def create
    @record = @model.new(record_params)
    if @record.save
      redirect_to path_for(@record, :show), notice: "#{@model.name} was successfully created."
    else
      render file: "crudable/new"
    end
  end

  def update
    if @record.update(record_params)
      redirect_to path_for(@record, :show), notice: "#{@model.name} was successfully updated."
    else
      render file: "crudable/edit"
    end
  end

  def destroy
    @record.destroy
    redirect_to  model_path(@model)
  end

  private

  def set_selected
    n = @model.name.downcase
    @selected = []
    if params[n]
      params[n].each do |key, value|
        selected_model = key.to_s.gsub('_id', '').classify.constantize
        @selected << selected_model.find_by_id(value)
      end
    end
  end
end
