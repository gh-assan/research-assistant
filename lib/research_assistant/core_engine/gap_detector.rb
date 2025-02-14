module ResearchAssistant
  module CoreEngine
    class GapDetector
      def initialize(api_client)
        @api_client = api_client
      end

      def detect(analysis, response)
        prompt = "Identify knowledge gaps in the following analysis based on the response: #{response}\n\nAnalysis: #{analysis}"
        api_response = @api_client.query(prompt)
        parse_response(api_response)
      end

      private

      def parse_response(response)
        # Assuming the response contains a list of knowledge gaps
        gaps = JSON.parse(response)
        gaps.map { |gap| { gap: gap['text'], severity: gap['severity'] } }
      end
    end
  end
end