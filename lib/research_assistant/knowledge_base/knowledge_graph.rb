module ResearchAssistant
  module KnowledgeBase
    class KnowledgeGraph
      include SmartProperties

      property :neo4j_connection

      def initialize(connection)
        @neo4j_connection = connection
      end

      def upsert_concept(concept_data)
        neo4j_connection.query(
          "MERGE (c:Concept {id: $id})
           SET c += $props
           RETURN c",
          id: concept_data[:id],
          props: concept_data.except(:id)
        )
      end

      def create_relationship(rel_data)
        neo4j_connection.query(
          "MATCH (a:Concept {id: $source_id}), (b:Concept {id: $target_id})
           MERGE (a)-[r:RELATIONSHIP {type: $type}]->(b)
           SET r += $props",
          source_id: rel_data[:source_id],
          target_id: rel_data[:target_id],
          type: rel_data[:type],
          props: rel_data.except(:source_id, :target_id, :type)
        )
      end

      def query_graph(cypher_query)
        neo4j_connection.query(cypher_query)
      end
    end
  end
end