module ResearchAssistant
  module KnowledgeBase
    class Knowledge
      include SmartProperties

      property :insights, accepts: Array, default: -> { [] }
      property :concepts, accepts: Array, default: -> { [] }
      property :relations, accepts: Array, default: -> { [] }
      property :knowledge_gaps, accepts: Array, default: -> { [] }
      property :questions, accepts: Array, default: -> { [] }
      property :article, accepts: String
      property :last_round_article, accepts: String
      property :user_intent, accepts: String, default: ""
      property :topic, accepts: String, default: ""
      property :iteration, accepts: Integer, default: 1
      property :max_iterations, accepts: Integer, default: 5
    end
  end
end
