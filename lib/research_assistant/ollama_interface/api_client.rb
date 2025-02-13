module ResearchAssistant
  module OllamaInterface
    class ApiClient
      def initialize(model: ResearchAssistant.config.ollama_model)
        @model = model
        @conn = Faraday.new(url: ResearchAssistant.config.ollama_url) do |f|
          f.request :json
          f.response :json
        end
      end

      def query(prompt)
        response = @conn.post('/api/generate') do |req|
          req.body = {
            model: @model,
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