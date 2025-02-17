require_relative 'models/response_schema_prompt'
module ResearchAssistant
  module CoreEngine
    class QuestionEngine
      include SmartProperties

      attr_reader :api_client, :json_api_client

      def initialize(api_client, json_api_client)
        @api_client = api_client
        @json_api_client = json_api_client
      end

      def extract(text)
        prompt = "Please analyze the given text and generate questions to challenge the text. The questions should be of the following types:
              Foundational Questions: Questions that address the basic principles and key concepts from the text.
              Critical Questions: Questions that examine the strength, weaknesses, or implications of the ideas presented.
              Counterfactual Questions: Questions that explore alternate scenarios or what could have been different if certain conditions changed.
              Synthesis Questions: Questions that seek to integrate and combine multiple ideas from the text to create new insights or solutions.
              it can have multiple questions of each type.:
             #{text}"
        response = api_client.query(prompt)
        parse_response(response)
      end

      private

      def parse_response(response)
        json_api_client.query(response, Models::QUESTIONS_SCHEMA)
      end
    end
  end
end