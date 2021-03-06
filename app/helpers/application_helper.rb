module ApplicationHelper
  def is_active?(name)
    "active" if controller_name.eql?(name)
  end
  # Get from https://github.com/xdite/bootstrap-helper
  def notice_message
    flash_messages = []
    flash.each do |type, message|
      type = :success if type == :notice
      type = :danger if type == :alert
      text = content_tag(:div, link_to("x", "#", :class => "close", "data-dismiss" => "alert") + message, :class => "alert fade in alert-#{type}")
      flash_messages << text if message
    end
    flash_messages.join("\n").html_safe
  end
end
