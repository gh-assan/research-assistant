module ResearchAssistant
  module KnowledgeBase
    class BrainstormingFileManager
      def initialize(research_id)
        @research_id = research_id
        @base_path = File.join(ResearchAssistant.config.research_dir, research_id)
        FileUtils.mkdir_p(@base_path)
      end

      def save_iteration(brainstorming_data, iteration_number)
        iteration_dir = File.join(@base_path, "iterations/#{iteration_number}")
        FileUtils.mkdir_p(iteration_dir)

        # Save article to .md file
        summary = brainstorming_data.summary
        
        File.write(File.join(iteration_dir, "summary.md"), summary)

        # Save remaining data to .json file
        File.write(File.join(iteration_dir, "multi_personals.md"), brainstorming_data.multi_personals) if brainstorming_data.multi_personals
        File.write(File.join(iteration_dir, "deep_dive.md"), brainstorming_data.deep_dive) if brainstorming_data.deep_dive
        File.write(File.join(iteration_dir, "reverse_brainstorming.md"), brainstorming_data.reverse_brainstorming) if brainstorming_data.reverse_brainstorming
        File.write(File.join(iteration_dir, "future_vision.md"), brainstorming_data.future_vision) if brainstorming_data.future_vision
        File.write(File.join(iteration_dir, "mind_mapping.md"), brainstorming_data.mind_mapping) if brainstorming_data.mind_mapping
        File.write(File.join(iteration_dir, "scamper_method.md"), brainstorming_data.scamper_method) if brainstorming_data.scamper_method

        pp "Iteration data saved to #{iteration_dir}"
      end
    end
  end
end