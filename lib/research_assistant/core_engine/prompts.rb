module ResearchAssistant
  module CoreEngine
    module Prompts
      QUESTION_GENERATION_PROMPT = <<~PROMPT
        You are a research assistant analyzing the topic: "<TOPIC>".

        Current Analysis:
        <ANALYSIS>

        Based on this, generate 3-5 high-quality research questions that:
        1. Explore foundational concepts
        2. Challenge existing assumptions
        3. Identify knowledge gaps
        4. Suggest interdisciplinary connections

        Format your response as JSON:
        {
          "questions": [
            {
              "text": "question text",
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