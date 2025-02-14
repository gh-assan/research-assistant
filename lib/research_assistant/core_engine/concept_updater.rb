module ResearchAssistant
  module CoreEngine
    class ConceptUpdater
      attr_reader :concept_extractor

      def initialize(concept_extractor)
        @concept_extractor = concept_extractor
      end

      def update(analysis, response)
        # Update concepts based on the response
        new_concepts = concept_extractor.extract(response).map { |concept| concept[:concept] }
        analysis[:core_concepts] ||= []
        analysis[:core_concepts] += new_concepts
        analysis[:core_concepts].uniq!
        analysis
      end
    end
  end
end