module ResearchAssistant
  module KnowledgeBase
    class Deduplicator
      include SmartProperties

      property :research_id
      property :similarity_threshold, default: 0.85

      def initialize(research_id)
        @research_id = research_id
        @base_path = File.join(ResearchAssistant.config.research_dir, research_id)
      end

      def check_duplicate(content, type:)
        case type
        when :text then text_similarity(content)
        when :concept then concept_similarity(content)
        when :relationship then relationship_exists?(content)
        end
      end

      private

      def text_similarity(new_content)
        existing_content = load_all_text_artifacts
        return false if existing_content.empty?

        existing_content.max_by { |c| similarity_score(c, new_content) }[1] > @similarity_threshold
      end

      def concept_similarity(concept)
        existing_concepts = Dir.glob(File.join(@base_path, 'concepts/*.json')).map do |path|
          JSON.parse(File.read(path), symbolize_names: true)
        end

        existing_concepts.any? do |ec|
          concept_similarity_score(ec, concept) > @similarity_threshold
        end
      end

      def relationship_exists?(rel)
        Dir.glob(File.join(@base_path, 'relationships/*.json')).any? do |path|
          existing = JSON.parse(File.read(path), symbolize_names: true)
          existing[:source] == rel[:source] &&
            existing[:target] == rel[:target] &&
            existing[:type] == rel[:type]
        end
      end

      def similarity_score(a, b)
        # Implement TF-IDF or cosine similarity
        # For simplicity, using Jaro-Winkler distance here
        distance = DidYouMean::JaroWinkler.distance(a, b)
        distance > @similarity_threshold
      end

      def concept_similarity_score(a, b)
        name_score = similarity_score(a[:name], b[:name])
        desc_score = similarity_score(a[:description].to_s, b[:description].to_s)
        (name_score * 0.7) + (desc_score * 0.3)
      end
    end
  end
end