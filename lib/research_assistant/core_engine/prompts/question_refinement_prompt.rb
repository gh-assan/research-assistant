module ResearchAssistant
  module CoreEngine
    module Prompts
      QUESTION_REFINEMENT_PROMPT = <<~PROMPT
        You are a research assistant refining questions for the topic: "<TOPIC>".

        Initial Questions:
        <QUESTIONS>

        Previous Responses:
        <RESPONSES>

        Refine the questions to:
        1. Address gaps in the responses
        2. Explore new angles suggested by the responses
        3. Remove redundant or irrelevant questions

        Format your response as JSON:
        {
          "questions": [
            {
              "text": "refined question text",
              "type": "foundational | critical | counterfactual | synthesis",
              "depth_level": 1-4,
              "target_concepts": ["array", "of", "concepts"]
            }
          ]
        }
      PROMPT
    end
  end
end