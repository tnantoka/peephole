module Peephole
  module ApplicationHelper
    def status_label(status)
      label = case status
              when /\A2/
                'success'
              when /\A3/
                'info'
              else
                'danger'
              end
      content_tag(:span, status, class: "label label-#{label}")
    end
  end
end
