module ResearchAssistant
  module CoreEngine
    class QuestionEngine
      include SmartProperties

      QUESTIONS_SCHEMA = <<~PROMPT
        Please analyze the given text to returns the questions in a structured response using the following format.:
        {
          "questions": [
            {
              "type": "foundational | critical | counterfactual | synthesis", 
              "question": "A question based on the text.",
              "priority": "high | medium | low", 
              "relevance": "The relevance of the question to the analysis.",
              "explanation": "A brief explanation of why this question of the type."
            }
          ]
        }
      PROMPT

      EXTRACT_QUESTIONS_PROMPT_TEMPLATE = <<~PROMPT
        Carefully analyze the given
        text : %<text>s
        -----------------------------------------
        Then,
        generate a set of thought-provoking questions to challenge its ideas. Your questions should be of the following types:

        Foundational Questions – Address the basic principles, assumptions, and key concepts presented in the text.
        Critical Questions – Examine the strengths, weaknesses, biases, and implications of the arguments.
        Counterfactual Questions – Explore alternate scenarios or how different conditions might have changed the conclusions.
        Synthesis Questions – Integrate multiple ideas from the text to generate new insights, theories, or solutions.
        First, generate a diverse set of questions across these categories. Then, take a second pass—go beyond the obvious. Push the boundaries by:

        Deepening foundational questions to explore hidden assumptions and conceptual blind spots.
        Strengthening critical questions to challenge the text from multiple angles, including ethical, philosophical, and interdisciplinary perspectives.
        Expanding counterfactual questions to consider extreme, improbable, or futuristic scenarios.
        Elevating synthesis questions by combining ideas in unexpected ways to generate innovative research directions.
        Generate multiple questions for each category, ensuring they provoke deeper thought and encourage critical engagement with the text.
      PROMPT

      attr_reader :reasoning_api_client, :json_api_client

      def initialize(reasoning_api_client, json_api_client)
        @reasoning_api_client = reasoning_api_client
        @json_api_client = json_api_client
      end

      def extract(text)
        prompt = format(EXTRACT_QUESTIONS_PROMPT_TEMPLATE, text: text)
        response = reasoning_api_client.query(prompt)
        parse_response(response)
      end

      private

      def parse_response(response)
        questions = json_api_client.query(response, QUESTIONS_SCHEMA)
        questions.is_a?(Hash) ? questions['questions'] : questions
      rescue StandardError => e
        pp " Error in parsing Questions #{e.message}"
        return []
      end
    end
  end
end