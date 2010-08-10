# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  # helper method to add a set of fields to a form
  def link_to_add_fields(name, f, association)
    # create a new template object to work with
    new_object = f.object.class.reflect_on_association(association).klass.new
    # create the new fields and render the partial containing these fields
    fields = f.fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
      render(association.to_s.singularize + "_fields", :f => builder)
    end
    link_to_function(name, h("add_fields(this, \"#{association}\", \"#{escape_javascript(fields)}\")"))
  end
end
