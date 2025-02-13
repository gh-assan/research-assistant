module ResearchAssistant
  module CoreEngine
    class IterationManager
      include SmartProperties

      # property :api_client, accepts: OllamaInterface::ApiClient
      property :api_client
      property :file_manager, accepts: KnowledgeBase::FileManager
      property :current_iteration, default: 0
      property :question_engine, accepts: QuestionEngine

      def initialize(**args)
        super
        @question_engine ||= QuestionEngine.new(api_client: api_client)
      end

      def run(analysis)
        while @current_iteration < ResearchAssistant.config.max_iterations
          @current_iteration += 1
          puts "Running iteration #{@current_iteration}..."

          # Generate questions based on the current state
          questions = question_engine.generate_questions(analysis)
          responses = questions.map { |q| api_client.query(q) }

          # Save iteration data
          iteration_data = {
            questions: questions,
            responses: responses,
            timestamp: Time.now.utc.iso8601
          }
          file_manager.save_iteration(@current_iteration, iteration_data)

          # Update analysis with new insights
          analysis = update_analysis(analysis, responses)
        end
      end

      private

      def update_analysis(analysis, responses)
        # Placeholder for updating the analysis with new insights
        # This could include new concepts, relationships, or gaps
        analysis.merge(
          insights: responses,
          updated_at: Time.now.utc.iso8601
        )
      end
    end
  end
end