module ResearchAssistant
  module KnowledgeBase
    class EnhancedManager
      include SmartProperties

      property :research_id
      property :validator, accepts: Validators::Validator
      property :neo4j_connection  # For knowledge graph

      def initialize(research_id)
        @research_id = research_id
        @base_path = File.join(ResearchAssistant.config.research_dir, research_id)
        setup_directory_structure
      end

      private

      def setup_directory_structure
        FileUtils.mkdir_p(@base_path)
        %w[
          /concepts
          /relationships
          /iterations
          /sources
          /versions
          /metadata
        ].each { |dir| FileUtils.mkdir_p(File.join(@base_path, dir)) }
      end
    end

    VERSION_FORMAT = "%Y%m%d%H%M%S".freeze

    def save_artifact(type:, content:, metadata: {})
      validate_and_save(type, content, metadata)
      update_knowledge_graph(content)
      index_content(content)
      create_version_snapshot
    end


    def validate_and_save(type, content, metadata)
      path = case type
             when :concept then save_concept(content, metadata)
             when :relationship then save_relationship(content, metadata)
             when :iteration then save_iteration(content, metadata)
             else raise "Unknown artifact type: #{type}"
             end

      validator.validate_file_structure(
        research_id: @research_id,
        files: [{
                  path: path,
                  type: type.to_s,
                  metadata: metadata.merge(saved_at: Time.now.utc.iso8601)
                }]
      )
    end

    def save_concept(content, metadata)
      concept_id = Digest::SHA256.hexdigest(content[:name])
      path = File.join(@base_path, "concepts/#{concept_id}.json")
      save_with_version(path, content)
      path
    end

    def save_relationship(content, metadata)
      rel_id = relationship_id(content)
      path = File.join(@base_path, "relationships/#{rel_id}.json")
      save_with_version(path, content)
      path
    end

    def save_iteration(content, metadata)
      iteration_num = content[:iteration_number]
      path = File.join(@base_path, "iterations/#{iteration_num}.json")
      save_with_version(path, content)
      path
    end

    def save_with_version(path, content)
      versioned_path = "#{path}.#{Time.now.strftime(VERSION_FORMAT)}"
      File.write(versioned_path, JSON.pretty_generate(content))
      FileUtils.ln_sf(versioned_path, path)
    end

    def relationship_id(content)
      sorted_nodes = [content[:source], content[:target]].sort
      Digest::SHA256.hexdigest("#{sorted_nodes.join}-#{content[:type]}")
    end
  end
end