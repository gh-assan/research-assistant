module ResearchAssistant
  module Agent
    class ArticleEnhancer
      attr_reader :write_api_client

      PROMPT = <<~PROMPT
        Here is a scientific article that needs improvement, along with an analysis result indicating what should be enhanced. 
        Your task is to refine the article accordingly, ensuring coherence, clarity, and depth.
        ---
        Article: %<article>s 
        ---
        executed_action: %<executed_action>s
        --- 
        analysis_output: %<analysis_output>s
        ---
        Please enhance the article based on the analysis action done on the article.
      PROMPT

      def initialize(write_api_client)
        @write_api_client = write_api_client
      end

      def enhance(article, executed_action, analysis_output)
        prompt = format(PROMPT, article: article, executed_action: executed_action, analysis_output: analysis_output)
        write_article(prompt)
      end

      private

      def write_article(prompt)
        write_api_client.write_article(prompt)
      rescue StandardError => e
        raise "Failed to generate article: #{e.message}"
      end
    end
  end
end