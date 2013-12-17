module ApplicationHelper
  def path_for(record, path_type = :show)
    if Part === record
      args = "(#{record.shoe.id},#{record.id})"
      name = "shoe_part_path"
    else
      args = "(#{record.id.to_s})"
      name = model_for(record).name.downcase + "_path"
    end
    case path_type
    when :edit
      eval "edit_#{name}#{args}"
    when :new
      eval "new_#{name}"
    when :show, :destroy
      eval "#{name}#{args}"
    end
  end

  def model_path(object)
    record = instance_for(object)
    case record
    when Part
      eval "shoe_parts_path(#{record.shoe_id})"
    else
      eval "#{model_for(record).name.downcase.pluralize}_path"
    end
  end

  def new_model_path(object, id = nil)
    model = model_for(object)
    if model == Part
      eval "new_shoe_part_path(#{id})"
    else
      eval "new_#{model.name.downcase}_path"
    end
  end

  def select_path(record, name, selected_array)
    i = record.id || ':new'
    case record
    when Shoe
      eval "shoe_color_path(#{i})"
    when Part
      case name
      when :partype
        eval "part_partype_path(#{record.shoe_id}, #{i})"
      when :matter
        partype_id = record.partype_id || 0
        selected_array.each do |s|
          partype_id = s.id if s.instance_of? Partype
        end
        eval "part_#{name}_path(#{record.shoe_id}, #{i}, #{partype_id})"
      end
    end
  end

  def path_for_selected(record, param)
    case record
    when Color
      p = "?shoe[color_id]=#{record.id.to_s}"
      if param[:shoe_id] == 'new'
        eval("new_shoe_path") + p
      else
        eval("edit_shoe_path(#{param[:shoe_id]})") + p
      end
    when Partype
      p = "?part[partype_id]=#{record.id.to_s}"
      path_for_selected_common(param, p)
    when Matter
      unless param[:partype_matters]
        p = "?part[matter_id]=#{record.id.to_s}&part[partype_id]=#{param[:partype_id]}"
        path_for_selected_common(param, p)
      else
        unless param[:remove_matter]
          eval("add_partype_matter_path(#{param[:partype_id]}, #{record.id})")
        else
          eval("remove_partype_matter_path(#{param[:partype_id]}, #{record.id})")
        end
      end
    end
  end

  def path_for_selected_common(param, p)
    if param[:part_id] == 'new'
      eval("new_shoe_part_path(#{param[:shoe_id]})") + p
    else
      eval("edit_shoe_part_path(#{param[:shoe_id]}, #{param[:part_id]})") + p
    end
  end

  def edit_collection_path(record, name)
    case record
    when Shoe
      eval("shoe_parts_path(#{record.id})")
    when Partype
      eval("partype_matters_path(#{record.id})")
    end
  end

  def model_for(object)
    return object if Class === object
    return object.class
  end

  def instance_for(object)
    return object.new if Class === object
    return object
  end

  def model_from_controller_name(name)
    name.gsub('partype_matters', 'matters').classify.constantize
  end

  def form_params(record, action_name)
    if action_name == 'new' || action_name == 'create'
      method = :post
      url = model_path(record)
    elsif action_name == 'edit'
      method = :put
      url = path_for(record, :show)
    end
    return {url: url, html: {method: method}}
  end

  def select_link_name(model, param)
    unless param[:remove_matter]
      "Select #{@model.name.downcase}"
    else
      "Remove matter"
    end
  end

  def add_link_name(model, controller_name)
    if controller_name == 'partype_matters'
      "Add matter"
    else
      "Add new #{model.name.downcase}"
    end
  end

  def add_link_path(model, controller_name, partype_id = nil)
    if controller_name == 'partype_matters'
      new_partype_matter_path(partype_id)
    else
      new_model_path(@model)
    end
  end

  def selectable_field_value(record, field, selected = nil)
    result = record.send(field.name) ? record.send(field.name).name : ''
    if selected && selected.size > 0
      selected.each {|s| result = s.name if s.class.name.downcase == field.name.to_s}
    end
    return result
  end

  def selectable_field_input_tag(record, field, selected = nil)
    id_value = record.send("#{field.name}_id")
    value = id_value ? id_value.to_s : ''
    if selected && selected.size > 0
      selected.each {|s| value = s.id if s.class.name.downcase == field.name.to_s}
    end
    hidden_field_tag(
      "#{record.class.name.downcase}_#{field.name}_id",
      value,
      name: "#{record.class.name.downcase}[#{field.name}_id]")
  end
end
