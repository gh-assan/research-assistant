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

      RELATIONS_SCHEMA = <<~PROMPT
      Please analyze the given text to identify relationships between concepts and provide a structured output in the following JSON format:
        {
          "relationships": [
            {
              "insight": "A concise summary of the identified relationship between concepts in the text.",
              "classification": "The category of the relationship within the analysis. Possible values: causal, comparative, associative, hierarchical.",
              "significance": "A brief explanation of why this relationship is important or how it contributes to understanding the text."
            }
          ]
        }
      PROMPT

      USER_INTENT_SCHEMA = <<~PROMPT
        As a scientific assistant, analyze the given prompt to understand the user's intent and convert it into a prompt to create a scientific article, make sure the prompt is short and clear.
        {
           "scientific_article_prompt": "A concise and precise prompt for creating a scientific article based on the user's intent."
        }
      PROMPT

      QUESTIONS_SCHEMA = <<~PROMPT
        Please analyze the given text to returns the questions in a structured response using the following format.:
        {
          "questions": [
            {
              "type": "foundational | critical | counterfactual | synthesis", 
              "question": "A question based on the text.",
              "priority": "high | medium | low", 
              "relevance": "The relevance of the question to the analysis.",
              "explanation": "A brief explanation of why this question of the type."
            }
          ]
        }
      PROMPT

      RANK_SCHEMA = <<~PROMPT
        Please analyze the text and assign a rank coming from the text . 
        Provide the response in the following format:
        {
          "rank": value, 
          "reasons": "A concise explanation of why the given score was assigned, highlighting strengths and areas for improvement."
        }
      PROMPT
    end
  end
end