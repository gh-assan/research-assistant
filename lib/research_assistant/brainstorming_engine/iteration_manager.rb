module ResearchAssistant
  module BrainstormingEngine
    class IterationManager
      attr_reader :brainstorming_integrator, :termination_evaluator, :research_id, :brainstorming_file_manager, :summary_generator

      def initialize(brainstorming_integrator, brainstorming_file_manager, summary_generator, termination_evaluator, research_id)
        @brainstorming_integrator = brainstorming_integrator
        @brainstorming_file_manager = brainstorming_file_manager
        @summary_generator = summary_generator
        @termination_evaluator = termination_evaluator
        @research_id = research_id
      end

      def run(topic, last_round_summary)
        iteration_number = 1
        loop do
          pp "Brainstorming Iteration #{iteration_number} for research ID #{research_id}"

          round_brainstorming_data = brainstorming_integrator.integrate(topic, iteration_number, last_round_summary)

          summary = summary_generator.generate_summary(round_brainstorming_data)

          round_brainstorming_data.summary = summary

          # Save iteration data
          brainstorming_file_manager.save_iteration(round_brainstorming_data, iteration_number)

          break if termination_evaluator.should_terminate?(iteration_number)

          iteration_number += 1
        end

        pp "Brainstorming completed for research ID #{research_id}"
      end
    end
  end
end