module Highlight
  HEADING_REGEX = /(<h([1-6])>)(.+)(<\/h([1-6])>)+/i
  CODE_REGEX    = /^``` ?([^\r\n]+)?\r?\n(.+?)\r?\n```\r?$/m
  
  class << self
    # Add anchors to all headings in html
    # @param text [String] input text data
    # @return [String] reformatted result
    def add_headings(text)
      text.gsub(HEADING_REGEX) do
        tag     = "h#{$2}"
        str     = $3.strip
        anchor  = str.gsub(/[^a-z\d\-]+/i, '-').downcase
        link    = "<a href='##{anchor}' class='anchor'>#{str}</a>"

        "<#{tag} id='#{anchor}'>#{link}</#{tag}>"
      end
    end
      
    # Render readme blob with flavored markup
    # @param body [String] content to render
    # @param format [String] markup format
    # @param hightlight [Boolean] enable language highlighting
    # @return [String] rendered html
    def render(body, format, highlight=true)
      data = body.gsub(CODE_REGEX) do
        if highlight && !$1.to_s.empty?
          str = $2
          if $2.bytesize > 0 && str.empty?
            str = "<pre>#{$2}</pre>"
          end
        else
          str = "<pre>#{$2}</pre>"
        end
        str
      end

      str = Docify.render(data, format)
      str = add_headings(str)
      str
    end
  end
end