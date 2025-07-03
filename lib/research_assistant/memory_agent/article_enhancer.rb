module ResearchAssistant
  module MemoryAgent
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

      def enhance(article, executed_actions, analysis_outputs)
        executed_actions_str = executed_actions.map(&:name).join(", ")
        analysis_outputs_str = analysis_outputs.join("\n\n")
        prompt = format(PROMPT, article: article, executed_action: executed_actions_str, analysis_output: analysis_outputs_str)
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