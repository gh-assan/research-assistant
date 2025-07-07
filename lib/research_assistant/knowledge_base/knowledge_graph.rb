require 'rgl/adjacency'
require 'json'

module ResearchAssistant
  module KnowledgeBase
    class KnowledgeGraph
      attr_reader :graph

      def initialize
        @graph = RGL::AdjacencyGraph.new
      end

      def add_concept(concept)
        @graph.add_vertex(concept) unless @graph.has_vertex?(concept)
      end

      def add_relationship(source_concept, target_concept, label)
        add_concept(source_concept)
        add_concept(target_concept)
        @graph.add_edge(source_concept, target_concept)
        # RGL doesn't support edge labels directly, so we store them separately for now.
        # A more robust solution might involve a custom edge class.
        @edge_labels ||= {}
        @edge_labels[[source_concept, target_concept]] = label
      end

      def find_related_concepts(concept)
        return [] unless @graph.has_vertex?(concept)
        @graph.adjacent_vertices(concept).map do |related_concept|
          {
            concept: related_concept,
            relationship: get_relationship_label(concept, related_concept)
          }
        end
      end

      def get_relationship_label(source_concept, target_concept)
        @edge_labels[[source_concept, target_concept]]
      end

      def to_json(*_args)
        {
          concepts: @graph.vertices,
          relationships: @graph.edges.map do |edge|
            {
              source: edge.source,
              target: edge.target,
              label: get_relationship_label(edge.source, edge.target)
            }
          end
        }.to_json
      end

      def self.from_json(json_string)
        data = JSON.parse(json_string)
        kg = new
        data['concepts'].each { |c| kg.add_concept(c) }
        data['relationships'].each do |r| 
          kg.add_relationship(r['source'], r['target'], r['label'])
        end
        kg
      end
    end
  end
end
