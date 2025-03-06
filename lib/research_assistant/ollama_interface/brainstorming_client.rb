module ResearchAssistant
  module OllamaInterface
    class BrainstormingClient

      attr_reader :model, :conn

      def initialize(model: ResearchAssistant.config.brainstorming_model)
        @model = model
        @conn = Faraday.new(url: ResearchAssistant.config.ollama_url) do |f|
          f.request :json
          f.response :json
          f.options.timeout = 600          
          f.options.open_timeout = 600     
        end
      end

      def brainstorm(prompt)
        response = conn.post('/api/generate') do |req|
          req.body = {
            model: model,
            prompt: prompt,
            stream: false
          }
        end

        raise "API Error: #{response.body['error']}" unless response.success?
        response.body['response']

      rescue Faraday::Error => e
        raise "Connection Error: #{e.message}"
      end
    end
  end
end