module ResearchAssistant
  module MemoryAgent
    class ActionDeterminer
      attr_reader :json_api_client, :action_history

      SCHEME = <<~SCHEME
        {
           "action": "<selected_action>",
           "reasons": "<reasons_for_selection>"
        }
      SCHEME

      def initialize(json_api_client)
        @json_api_client = json_api_client
        @action_history = []
      end

      def get_next_action(article, memory)
        input = {
          article: article,
          action_history: action_history,
          memory: memory
        }

        response = json_api_client.query(input.to_json, SCHEME)

        response.map do |action_data|
          action = Action.new(name: action_data['action'], reasons: action_data['reasons'], key: action_data['key'], value: action_data['value'])
          action_history << action.name
          action
        end
      end
    end
  end
end