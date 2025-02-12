module ResearchAssistant
  module Output
    class TemplateEngine
      def render(format, content)
        case format
        when :markdown then render_markdown(content)
        when :latex then render_latex(content)
        when :html then render_html(content)
        else raise "Unsupported format: #{format}"
        end
      end

      private

      def render_markdown(content)
        <<~MARKDOWN
          # #{content[:title]}

          **Abstract**  
          #{content[:abstract]}

          #{content[:sections].map { |s| "## #{s[:title]}\n\n#{s[:content]}" }.join("\n\n")}
        MARKDOWN
      end

      def render_latex(content)
        <<~LATEX
          \\documentclass{article}
          \\title{#{content[:title]}}
          \\begin{document}
          \\maketitle

          \\begin{abstract}
          #{content[:abstract]}
          \\end{abstract}

          #{content[:sections].map { |s| "\\section{#{s[:title]}}\n\n#{s[:content]}" }.join("\n\n")}

          \\end{document}
        LATEX
      end

      def render_html(content)
        <<~HTML
          <!DOCTYPE html>
          <html>
          <head>
            <title>#{content[:title]}</title>
          </head>
          <body>
            <h1>#{content[:title]}</h1>
            <h2>Abstract</h2>
            <p>#{content[:abstract]}</p>

            #{content[:sections].map { |s| "<h2>#{s[:title]}</h2>\n<p>#{s[:content]}</p>" }.join("\n")}
          </body>
          </html>
        HTML
      end
    end
  end
end