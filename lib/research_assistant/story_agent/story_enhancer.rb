module ResearchAssistant
  module StoryAgent
    class StoryEnhancer
      attr_reader :write_api_client

      PROMPT = <<~PROMPT
        Here is a story that needs improvement, along with an analysis result indicating what should be enhanced. 
        Your task is to refine the story accordingly, ensuring coherence, clarity, and depth.
        ---
        Story: %<story>s 
        ---
        executed_action: %<executed_action>s
        --- 
        analysis_output: %<analysis_output>s
        ---
        Please enhance the story based on the analysis action done on the story.
      PROMPT

      def initialize(write_api_client)
        @write_api_client = write_api_client
      end

      def enhance(story, executed_action, analysis_output)
        prompt = format(PROMPT, story: story, executed_action: executed_action, analysis_output: analysis_output)
        write_story(prompt)
      end

      private

      def write_story(prompt)
        write_api_client.write_article(prompt)
      rescue StandardError => e
        raise "Failed to generate the story: #{e.message}"
      end
    end
  end
end