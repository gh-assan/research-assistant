require_relative '../knowledge_base/brainstorming_data'

module ResearchAssistant
  module BrainstormingEngine
    class BrainstormingIntegrator
      attr_reader :multi_personals, :deep_dive, :reverse_brainstorming, :future_vision, :mind_mapping, :scamper_method

      def initialize(multi_personals:, deep_dive:, reverse_brainstorming:, future_vision:, mind_mapping:, scamper_method:)
        @multi_personals = multi_personals
        @deep_dive = deep_dive
        @reverse_brainstorming = reverse_brainstorming
        @future_vision = future_vision
        @mind_mapping = mind_mapping
        @scamper_method = scamper_method
      end

      def integrate(topic, iteration_number, last_round_summary)
        pp "BrainstormingIntegrator start integrating brainstorming results for iteration #{iteration_number}"

        multi_personals_results = multi_personals.run(topic, last_round_summary)
        deep_dive_results = deep_dive.run(topic, last_round_summary)
        reverse_brainstorming_results = reverse_brainstorming.run(topic, last_round_summary)
        future_vision_results = future_vision.run(topic, last_round_summary)
        mind_mapping_results = mind_mapping.run(topic, last_round_summary)
        scamper_results = scamper_method.run(topic, last_round_summary)

        brainstorming_data = ResearchAssistant::KnowledgeBase::BrainstormingData.new(
          multi_personals: multi_personals_results,
          deep_dive: deep_dive_results,
          reverse_brainstorming: reverse_brainstorming_results,
          future_vision: future_vision_results,
          mind_mapping: mind_mapping_results,
          scamper_method: scamper_results,
          topic: topic,
          last_round_summary: last_round_summary
        )

        pp "BrainstormingIntegrator finished integrating brainstorming results for iteration #{iteration_number}"
        brainstorming_data
      end
    end
  end
end