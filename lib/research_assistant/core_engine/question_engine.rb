module ResearchAssistant
  module CoreEngine
    class QuestionEngine
      include SmartProperties

      # property :api_client, accepts: OllamaInterface::ApiClient
      property :api_client
      property :validator, accepts: Validators::Validator, default: -> { Validators::Validator.new }

      def generate_questions(analysis)
        questions = []

        # 1. Foundational Questions
        questions += generate_foundational_questions(analysis)

        # 2. Critical Analysis Questions
        questions += generate_critical_questions(analysis)

        # 3. Counterfactual Questions
        questions += generate_counterfactual_questions(analysis)

        # 4. Synthesis Questions
        questions += generate_synthesis_questions(analysis)

        # 5. Prioritize and diversify questions
        prioritized_questions = prioritize_questions(questions)

        # Validate and return
        validator.validate_question_generation(questions: prioritized_questions)
      end

      private

      def generate_foundational_questions(analysis)
        analysis[:core_concepts].map do |concept|
          {
            text: "What is the definition of #{concept} in the context of #{analysis[:topic]}?",
            type: "foundational",
            depth_level: 1,
            target_concepts: [concept]
          }
        end
      end

      def generate_critical_questions(analysis)
        analysis[:relationships].map do |relationship|
          {
            text: "What evidence supports the relationship between #{relationship[:source]} and #{relationship[:target]}?",
            type: "critical",
            depth_level: 2,
            target_concepts: [relationship[:source], relationship[:target]]
          }
        end
      end

      def generate_counterfactual_questions(analysis)
        analysis[:core_concepts].flat_map do |concept|
          [
            {
              text: "What would happen if #{concept} did not exist?",
              type: "counterfactual",
              depth_level: 3,
              target_concepts: [concept]
            },
            {
              text: "How would the field change if #{concept} worked differently?",
              type: "counterfactual",
              depth_level: 3,
              target_concepts: [concept]
            }
          ]
        end
      end

      def generate_synthesis_questions(analysis)
        analysis[:core_concepts].combination(2).map do |concept1, concept2|
          {
            text: "How can #{concept1} be applied to improve #{concept2}?",
            type: "synthesis",
            depth_level: 4,
            target_concepts: [concept1, concept2]
          }
        end
      end

      def prioritize_questions(questions)
        questions.sort_by do |question|
          [
            -question[:depth_level], # Higher depth first
            question[:type] == "synthesis" ? 0 : 1, # Prioritize synthesis
            question[:target_concepts].size # More concepts first
          ]
        end
      end
    end
  end
end