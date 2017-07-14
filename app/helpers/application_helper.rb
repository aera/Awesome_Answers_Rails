module ApplicationHelper
  # Helpers, which you create yourself or rails generates everytime you create
  # a controller, are meant to be used to create simple functions that return
  # HTML for your views. This is a great to avoid repeating yourself in your
  # template files.

  # Your helper must return a string containing text or html as they're used for
  # that purpose. You can combine any number of rails pre-existing helper methods
  # (e.g. form_for, link_to, question_path, content_tag, input_tag, etc) to create
  # your methods.

  def errors_for(model)
    unless model.errors.empty?
      content_tag :div, model.errors.full_messages.join(', ')
    end
  end

  def not_html_safe
    # by default, strings returned from an helper method are escaped. Meaning
    # that special character to HTML are replaced by versions that aren't interpreted
    # as HTML.
    '<div class="not-html-safe">This is the string your mom warned you about</div>'.html_safe
    # ^ use .html_safe method to render string as html
  end
end
