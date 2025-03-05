module ResearchAssistant
  module Output
    class SummaryGenerator
      attr_reader :write_api_client

      def initialize(write_api_client)
        @write_api_client = write_api_client
      end

      def generate_summary(brainstorming_data)
        prompt = build_prompt(brainstorming_data)
        write_summary(prompt)
      end

      private

      def build_prompt(brainstorming_data)
        <<~PROMPT
          Write a summary that covers all the discussions in the following Brainstorming sessions Data :
          On the Topic: #{brainstorming_data.topic}

          ----------
          Based on Brainstorming Sessions Output:
          #{format_section(brainstorming_data.scamper_method)}
          #{format_section(brainstorming_data.multi_personals)}
          #{format_section(brainstorming_data.deep_dive)}
          #{format_section(brainstorming_data.reverse_brainstorming)}
          #{format_section(brainstorming_data.future_vision)}
          #{format_section(brainstorming_data.mind_mapping)}
            
          Check your last round Responses and build on top of it:
          #{brainstorming_data.last_round_summary}
        PROMPT
      end

      def format_section(brainstorming_session_output)
        "--> brainstorming session output #{brainstorming_session_output} <--" if brainstorming_session_output
      end

      def write_summary(prompt)
        write_api_client.write_article(prompt)
      rescue StandardError => e
        raise "Failed to generate Brainstorming summary : #{e.message}"
      end
    end
  end
end