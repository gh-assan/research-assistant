module ResearchAssistant
  module KnowledgeBase
    class SearchEngine
      include SmartProperties

      property :research_id
      property :elasticsearch_client

      def initialize(research_id, es_client)
        @research_id = research_id
        @elasticsearch_client = es_client
        create_index_if_missing
      end

      def index_content(content)
        elasticsearch_client.index(
          index: index_name,
          id: content[:id],
          body: content
        )
      end

      def search(query, filters: {})
        search_body = {
          query: {
            bool: {
              must: {
                multi_match: {
                  query: query,
                  fields: ['name^3', 'description', 'content']
                }
              },
              filter: filters.map { |k,v| { term: { k => v } } }
            }
          }
        }

        elasticsearch_client.search(index: index_name, body: search_body)
      end

      private

      def index_name
        "research-#{research_id}"
      end

      def create_index_if_missing
        return if elasticsearch_client.indices.exists?(index: index_name)

        elasticsearch_client.indices.create(
          index: index_name,
          body: {
            settings: {
              analysis: {
                analyzer: {
                  research_analyzer: {
                    tokenizer: 'standard',
                    filter: %w[lowercase asciifolding]
                  }
                }
              }
            },
            mappings: {
              properties: {
                name: { type: 'text', analyzer: 'research_analyzer' },
                content: { type: 'text', analyzer: 'research_analyzer' },
                type: { type: 'keyword' },
                timestamp: { type: 'date' }
              }
            }
          }
        )
      end
    end
  end
end