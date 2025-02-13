module ResearchAssistant
  module CoreEngine
    class DeepSeekQuestionGenerator
      include SmartProperties

      property :api_client, accepts: OllamaInterface::ApiClient
      property :validator, accepts: Validators::Validator

      def generate(topic, analysis)
        prompt = build_prompt(topic, analysis)
        response = api_client.query(prompt)
        parse_response(response)
      end

      private

      def build_prompt(topic, analysis)
        Prompts::QUESTION_GENERATION_PROMPT
          .gsub("<TOPIC>", topic)
          .gsub("<ANALYSIS>", analysis.to_json)
      end

      def parse_response(response)
        json_str = response.match(/\{.*\}/m).to_s
        data = JSON.parse(json_str, symbolize_names: true)
        validator.validate_question_generation(data)
      rescue JSON::ParserError => e
        raise ValidationError, "Failed to parse DeepSeek response: #{e.message}"
      end
    end
  end
end# frozen_string_literal: true

