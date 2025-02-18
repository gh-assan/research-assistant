module ResearchAssistant
  module KnowledgeBase
    class Knowledge
      include SmartProperties

      property :insights, accepts: Array
      property :concepts, accepts: Array
      property :relations, accepts: Array
      property :knowledge_gaps, accepts: Array
      property :questions, accepts: Array
      property :article, accepts: String
      property :user_intent, accepts: String
      property :topic, accepts: String
      property :iteration, accepts: Integer

      # def initialize
      #   @insights = []
      #   @concepts = [],
      #   @knowledge_gaps = []
      #   @questions = []
      #   @article = ""
      #   @user_intent = ""
      #   @topic=  ""
      #   @iteration = 0
      # end
    end
  end
end
