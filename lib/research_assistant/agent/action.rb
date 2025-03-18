module ResearchAssistant
  module Agent
    class Action
      include SmartProperties

      property :name, accepts:String
      property :reasons, accepts: String

      def to_command
        "Please apply the action #{name} because of #{reasons}"
      end
    end
  end
end
