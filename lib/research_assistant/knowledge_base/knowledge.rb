module ResearchAssistant
  module KnowledgeBase
    class Knowledge
      include SmartProperties

      property :insights, accepts:String
      property :concepts, accepts: String
      property :relations, accepts: String
      property :knowledge_gaps, accepts: String
      property :questions, accepts: String
      property :article, accepts: String
      property :last_round_article, accepts: String
      property :user_intent, accepts: String, default: ""
      property :topic, accepts: String, default: ""
      property :iteration, accepts: Integer, default: 1
      property :max_iterations, accepts: Integer, default: -> {ResearchAssistant.config.max_iterations}
    end
  end
end
