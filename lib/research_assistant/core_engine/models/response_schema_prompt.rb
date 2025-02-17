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

      GAPS_SCHEMA = <<~PROMPT
      Please analyze the given text to identify knowledge gaps in the analysis and provide a structured output in the following JSON format:
        {
            "knowledge_gaps": [
              {
                "insight": "A concise summary of the missing or incomplete concept in the analysis.",
                "classification": "The category of the gap within the analysis. Possible values: foundational, critical, counterfactual, synthesis.",
                "significance": "A brief explanation of why addressing this gap is important for improving the analysis."
              }
            ]
        }
      PROMPT
    end
  end
end