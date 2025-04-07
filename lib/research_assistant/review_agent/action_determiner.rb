module ResearchAssistant
  module ReviewAgent
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

      def get_next_action(story)
        input = {
          story: story,
          action_history: action_history
        }

        response = json_api_client.query(input.to_s, SCHEME)

        action = Action.new(name: response['action'], reasons: response['reasons'])
        action_history << action.name

        action
      end
    end
  end
end