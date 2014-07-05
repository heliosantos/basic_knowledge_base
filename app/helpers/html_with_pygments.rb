module HtmlWithPygments
  class HtmlWithPygmentsRender < Redcarpet::Render::HTML
    def block_code(code, language)
      Pygments.highlight(code, lexer: language)
    end
  end
  
  def markdown(text)
    renderer = HtmlWithPygmentsRender.new(render_options = {hard_wrap: true, filter_html: true, autolink: true, no_intra_emphasis: true, fenced_code_blocks: true})
    markdown = Redcarpet::Markdown.new(renderer, extensions = {autolink: true, no_intra_emphasis: true, fenced_code_blocks: true})
    markdown.render(text)
  end

end