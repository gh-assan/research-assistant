module ResearchAssistant
  module MemoryAgent
    class Action
      include SmartProperties

      property :name, accepts:String
      property :reasons, accepts: String
      property :key, accepts: String, default: nil
      property :value, accepts: String, default: nil

      def to_command
        "Please apply the action #{name} because of #{reasons}"
      end
    end
  end
end
