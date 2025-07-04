require 'json'
require_relative '../knowledge_base/knowledge_graph'
require_relative 'contextual_retriever'

module ResearchAssistant
  module MemoryAgent
    class MemoryManager
      def initialize(research_id)
        @base_path = File.join(ResearchAssistant.config.research_dir, research_id)
        @memory_file = File.join(@base_path, 'knowledge_graph.json')
        pp "MemoryManager: Initializing memory file: #{@memory_file}"

        if File.exist?(@memory_file)
          @knowledge_graph = KnowledgeBase::KnowledgeGraph.from_json(File.read(@memory_file))
        else
          @knowledge_graph = KnowledgeBase::KnowledgeGraph.new
          FileUtils.mkdir_p(File.dirname(@memory_file))
          write(@knowledge_graph)
        end
        @contextual_retriever = ContextualRetriever.new
      end

      def read
        @knowledge_graph
      end

      def write(kg)
        pp "MemoryManager: Writing to file: #{@memory_file}"
        pp "MemoryManager: Data to write: #{kg.to_json}"
        File.write(@memory_file, kg.to_json)
      end

      def retrieve_contextual_memories(context, limit = 5)
        all_memories = @knowledge_graph.graph.vertices
        @contextual_retriever.retrieve_contextual_memories(all_memories, context, limit)
      end
    end
  end
end
