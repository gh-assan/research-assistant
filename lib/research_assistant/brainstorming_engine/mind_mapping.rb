module ResearchAssistant
  module BrainstormingEngine
    class MindMapping < BaseBrainstorming

      PROMPT = <<~PROMPT
        Let's create a comprehensive mind map for %<topic>s  by following these steps:

        Central Idea:

        Place %<topic>s  at the center of your mind map.
        Main Branches:

        Identify major subtopics or themes related to %<topic>s .
        Label each branch clearly (e.g., history, key features, challenges, benefits, ..).
        Subtopics & Related Concepts:

        For each main branch, break down into smaller, related subtopics or concepts.
        Consider factors such as influencing elements, target audiences, or contextual factors, etc.
        Potential Applications & Connections:

        Explore practical applications or real-life examples for each branch.
        Identify innovative or unexpected connections between subtopics.
        Ask: How do these ideas intersect or complement each other?
        New Insights:

        Challenge yourself with questions like: What new perspectives or uses can be derived?
        Look for areas where combining ideas might open up novel opportunities.
        Use this structured approach to uncover fresh insights and create a dynamic, interconnected mind map for %<topic>s .
        ---
        please take into account the summary of the last round of brainstorming: %<last_round_summary>s
      PROMPT
    end
  end
end