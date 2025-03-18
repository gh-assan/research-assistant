module ResearchAssistant
  module Agent
    class ActionDeterminer
      attr_reader :json_api_client

      SCHEME = <<~SCHEME
        {
           "action": "<selected_action>",
           "reasons": "<reasons_for_selection>",
        }
      SCHEME

      def initialize(json_api_client)
        @json_api_client = json_api_client
      end

      def get_next_action(article)
        response = json_api_client.query(article, SCHEME)
        response['action']
      end
    end
  end
end