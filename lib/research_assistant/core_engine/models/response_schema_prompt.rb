module ResearchAssistant
  module CoreEngine
    module Models
      CONCEPTS_SCHEMA = <<~PROMPT
        Please analyze the text and respond with the Format below:
        {
          "concepts": [
            {
              "concept": "The text of the concept extracted from the response.",
              "relevance": "The relevance of the concept to the analysis. Possible values: foundational, critical, counterfactual, synthesis."
            }
          ]
        }
      PROMPT
    end
  end
end