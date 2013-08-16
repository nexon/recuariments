module ApplicationHelper
  def is_active?(name)
    "active" if controller_name.eql?(name)
  end
  
  def link_to_add_fields(name, f, association)
    new_object = f.object.send(association).klass.new
    id = new_object.object_id
    fields = f.simple_fields_for(association, new_object, child_index: id) do |f|
      render(association.to_s.singularize + "_fields", f: f)
    end
    link_to(name, '#', class: "btn add_fields", data:{id: id, fields: fields.gsub("\n", "")})
  end
end
