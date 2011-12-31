module UsersHelper
  def invalid?(object, field)
    object.errors.include?(field)
  end

  def field_for(object, field, &block)
    classes = [ "clearfix" ]
    classes << "error" if invalid?(object, field)
    content = with_output_buffer(&block)
    content_tag(:div, content, class: classes)
  end
end
