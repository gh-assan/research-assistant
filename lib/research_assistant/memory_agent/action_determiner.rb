module ResearchAssistant
  module MemoryAgent
    class ActionDeterminer
      attr_reader :json_api_client, :action_history

      SCHEME = <<~SCHEME
        {
           "action": "<selected_action>",
           "reasons": "<reasons_for_selection>",
           "key": "<key_for_action>",
           "value": "<value_for_action>"
        }
      SCHEME

      def initialize(json_api_client)
        @json_api_client = json_api_client
        @action_history = []
      end

      def get_next_action(article, knowledge_graph)
        prompt_text = <<~PROMPT
          You are an AI research assistant. Your goal is to analyze the provided article and the current state of the knowledge graph to determine the next best action to enhance the research.

          Available actions:
          - `extract_insights`: Extract key insights from the article.
          - `extract_concepts`: Identify and extract core concepts from the article.
          - `detect_gaps`: Find missing information or logical gaps in the article.
          - `generate_questions`: Formulate questions based on the article to guide further research.
          - `find_relations`: Discover relationships between concepts in the article.
          - `add_concept`: Add a new concept to the knowledge graph. Use this when you identify a significant new entity or idea.
            Example: { "action": "add_concept", "reasons": "Identified a new key entity", "value": "Quantum Entanglement" }
          - `add_relationship`: Add a relationship between two existing concepts in the knowledge graph. Use this when you find a connection between two concepts.
            Example: { "action": "add_relationship", "reasons": "Found a causal link", "key": "Cause Concept", "value": "Effect Concept" }
          - `find_related_concepts`: Find concepts related to a given concept in the knowledge graph.

          Current Article: #{article}
          Current Knowledge Graph: #{knowledge_graph.to_json}
          Action History: #{action_history.join(', ')}

          Based on the above, what is the single best action to take next? Provide your response in JSON format according to the SCHEME.
        PROMPT

        response_from_api = json_api_client.query(prompt_text, SCHEME)
        pp "ActionDeterminer: Raw response from JsonApiClient: #{response_from_api.inspect}"

        response_from_api.map do |action_data|
          # If the value is a Hash, convert it to a JSON string for Action property
          value = action_data['value']
          value = value.to_json if value.is_a?(Hash)
          action = Action.new(name: action_data['action'], reasons: action_data['reasons'], key: action_data['key'], value: value)
          action_history << action.name
          action
        end
      end
    end
  end
end