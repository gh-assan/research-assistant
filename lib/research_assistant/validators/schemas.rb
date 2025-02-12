module ResearchAssistant
  module Validators
    module Schemas
      # Schema for topic analysis output
      AnalysisSchema = Dry::Schema.Params do
        required(:core_concepts).value(array[:string]).filled
        required(:relationships).value(array[:hash]).each do
          schema do
            required(:source).filled(:string)
            required(:target).filled(:string)
            required(:type).filled(:string)
          end
        end
        optional(:insights).value(array[:string])
        optional(:updated_at).value(:time)
      end

      # Schema for iteration data (questions and responses)
      IterationSchema = Dry::Schema.Params do
        required(:questions).value(array[:string]).filled
        required(:responses).value(array[:string]).filled
        required(:timestamp).value(:time)
      end

      # Schema for Ollama API responses
      OllamaResponseSchema = Dry::Schema.Params do
        required(:response).filled(:string)
        optional(:error).maybe(:string)
      end

      # Schema for question generation output
      QuestionGenerationSchema = Dry::Schema.Params do
        required(:questions).value(array[:hash]).each do
          schema do
            required(:text).filled(:string)
            required(:type).filled(:string)
            required(:depth_level).value(:integer, gteq?: 1, lteq?: 5)
            optional(:target_concepts).value(array[:string])
          end
        end
      end

      # Schema for research logs
      ResearchLogSchema = Dry::Schema.Params do
        required(:entries).value(array[:hash]).each do
          schema do
            required(:timestamp).value(:time)
            required(:action).filled(:string)
            required(:details).value(:hash)
          end
        end
      end

      # Schema for file structures
      FileStructureSchema = Dry::Schema.Params do
        required(:research_id).filled(:string)
        required(:files).value(array[:hash]).each do
          schema do
            required(:path).filled(:string)
            required(:type).filled(:string, included_in?: %w[analysis iteration log output])
            optional(:metadata).value(:hash)
          end
        end
      end
    end
  end
end