# frozen_string_literal: true

module ApplicationHelper
  def render_source
    "#{controller_name} #{action_name}"
  end
end
