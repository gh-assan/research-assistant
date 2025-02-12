module ResearchAssistant
  module Validators
    class Validator
      include SmartProperties

      def validate_analysis(data)
        result = Schemas::AnalysisSchema.call(data)
        raise ValidationError, "Invalid analysis: #{result.errors.to_h}" if result.failure?
        result.to_h
      end

      def validate_iteration(data)
        result = Schemas::IterationSchema.call(data)
        raise ValidationError, "Invalid iteration data: #{result.errors.to_h}" if result.failure?
        result.to_h
      end

      def validate_ollama_response(data)
        result = Schemas::OllamaResponseSchema.call(data)
        raise ValidationError, "Invalid Ollama response: #{result.errors.to_h}" if result.failure?
        result.to_h
      end

      def validate_question_generation(data)
        result = Schemas::QuestionGenerationSchema.call(data)
        raise ValidationError, "Invalid question generation output: #{result.errors.to_h}" if result.failure?
        result.to_h
      end

      def validate_research_log(data)
        result = Schemas::ResearchLogSchema.call(data)
        raise ValidationError, "Invalid research log: #{result.errors.to_h}" if result.failure?
        result.to_h
      end

      def validate_file_structure(data)
        result = Schemas::FileStructureSchema.call(data)
        raise ValidationError, "Invalid file structure: #{result.errors.to_h}" if result.failure?
        result.to_h
      end
    end
  end
end