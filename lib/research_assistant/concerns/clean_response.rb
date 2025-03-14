module ResearchAssistant
  module Concerns
    module CleanResponse
      def clean_response(response)
        response.gsub(/<think>.*?<\/think>/m, '')
      end
    end
  end
end