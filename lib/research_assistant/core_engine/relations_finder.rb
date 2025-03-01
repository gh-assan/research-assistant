module ResearchAssistant
  module CoreEngine
    class RelationsFinder

      RELATIONS_SCHEMA = <<~PROMPT
      Please analyze the given text to identify relationships between concepts and provide a structured output in the following JSON format:
        {
          "relationships": [
            {
              "insight": "A concise summary of the identified relationship between concepts in the text.",
              "classification": "The category of the relationship within the analysis. Possible values: causal, comparative, associative, hierarchical.",
              "significance": "A brief explanation of why this relationship is important or how it contributes to understanding the text."
            }
          ]
        }
      PROMPT

      FIND_RELATIONS_PROMPT_TEMPLATE = <<~PROMPT
        Carefully analyze the given text
        Topic: %<topic>s
        Text: %<text>s
        Analysis: %<analysis>s
        ----------------------------------------
        then identify meaningful relationships between concepts within the topic and across other disciplines. Your analysis should explore connections across multiple dimensions, including:

        Causal Relationships – How do certain concepts influence or drive changes in others?
        Hierarchical Relationships – Which concepts are foundational, and which are dependent or derived?
        Comparative Relationships – How do concepts contrast, complement, or interact with each other?
        Interdisciplinary Relationships – How do these ideas connect to insights from other fields (e.g., neuroscience, psychology, philosophy, mathematics, engineering, linguistics, economics, etc.)?
        Emergent Relationships – Are there unexpected, nonlinear, or hidden patterns that arise from combining concepts?

        Deepening the Analysis:
        First, identify explicit relationships within the topic itself. Then, take a second pass—push beyond the obvious.

        Find hidden interdisciplinary connections – How could concepts from this field apply to other disciplines? What insights from other fields could refine or challenge these ideas?
        Identify paradoxes or contradictions – Are there conflicting viewpoints or tensions when integrating insights from different fields?
        Consider historical and future perspectives – How have these relationships evolved over time? How might they change with new discoveries or societal shifts?
        Speculate on unconventional links – Could an analogy or principle from a completely different discipline (e.g., quantum mechanics, game theory, mythology, artificial intelligence) offer a fresh perspective?
        Generate multiple relationships across these categories, ensuring a rich, interdisciplinary, and thought-provoking exploration of conceptual interconnections.
      PROMPT

      attr_reader :api_client, :json_api_client

      def initialize(api_client, json_api_client)
        @api_client = api_client
        @json_api_client = json_api_client
      end

      def find_relations(topic, text, analysis)
        prompt = format(FIND_RELATIONS_PROMPT_TEMPLATE, topic: topic, text: text, analysis: analysis)
        response = api_client.query(prompt)
        parse_response(response)
      end

      private

      def parse_response(response)
        relationships = json_api_client.query(response, RELATIONS_SCHEMA)
        relationships.is_a?(Hash) ? relationships['relationships'] : relationships
      rescue StandardError => e
        pp " Error in parsing relationships #{e.message}"
        return []
      end
    end
  end
end