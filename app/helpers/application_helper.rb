# frozen_string_literal: true

module ApplicationHelper
  def same_as_current_path?(path)
    request.path_info.include? path
  end
end
