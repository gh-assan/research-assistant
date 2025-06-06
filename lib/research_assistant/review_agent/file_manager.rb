module ResearchAssistant
  module ReviewAgent
    class FileManager
      def initialize(story_id)
        @story_id = story_id
        @base_path = File.join(ResearchAssistant.config.story_dir, story_id)
        FileUtils.mkdir_p(@base_path)
      end

      def save_iteration(text, iteration, action)
        iteration_dir = File.join(@base_path, "iterations/#{iteration}")
        FileUtils.mkdir_p(iteration_dir)

        File.write(File.join(iteration_dir, "text.md"), text)

        File.write(File.join(iteration_dir, 'action.md'), action.to_command)

        pp "Iteration data saved to #{iteration_dir}"
      end
    end
  end
end