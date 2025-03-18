module ResearchAssistant
  module Agent
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

      def get_next_action(article)
        # Combine the article and action history
        input = {
          article: article,
          action_history: action_history
        }

        # Query the client with the combined input
        response = json_api_client.query(input.to_s, SCHEME)

        # Create the action and update the history
        action = Action.new(name: response['action'], reasons: response['reasons'])
        action_history << action.name

        action
      end
    end
  end
end