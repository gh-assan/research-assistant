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

      INSIGHTS_SCHEMA = <<~PROMPT
        {
          "insights": [
            {
              "insight": "A concise summary of the extracted concept from the text.",
              "classification": "The category of the concept within the analysis. Possible values: foundational, critical, counterfactual, synthesis.",
              "significance": "A brief explanation of why this insight is important or how it contributes to the overall analysis."
            }
          ]
        }
      PROMPT
    end
  end
end