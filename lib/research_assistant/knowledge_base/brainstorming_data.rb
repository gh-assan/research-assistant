module ResearchAssistant
  module KnowledgeBase
    class BrainstormingData
      include SmartProperties
      
        property :multi_personals, accepts: String, default: ''
        property :deep_dive, accepts: String, default: ''
        property :reverse_brainstorming, accepts: String, default: ''
        property :future_vision, accepts: String, default: ''
        property :mind_mapping, accepts: String, default: ''
        property :scamper_method, accepts: String, default: ''
        property :summary, accepts: String
        property :last_round_summary, accepts: String
        property :topic, accepts: String, default: ""
    end
  end
end