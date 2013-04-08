class BreadcrumbsBuilder < BreadcrumbsOnRails::Breadcrumbs::SimpleBuilder
  def render
    @elements.collect do |element|
      render_element(element)
    end.join("<span class='divider'>#{@options[:separator] || ' &raquo; '}</span>")
  end
end