module ApplicationHelper

  def title
    base = "VoiceBox"
    if @title.nil?
      "#{base} | Your online voice box"
    else
      "#{base} | #{@title}"
    end
  end

  def nav_link(name, path)
    if current_page?(path)
      "<li class=\"active\">#{link_to(name, path)}</li>".html_safe
    else
      "<li>#{link_to(name, path)}</li>".html_safe
    end
  end
end
