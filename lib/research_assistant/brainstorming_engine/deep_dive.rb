module ResearchAssistant
  module BrainstormingEngine
    class DeepDive < BaseBrainstorming

      PROMPT = <<~PROMPT
        Deep Dive Exploration on %<topic>s 

        Initial Inquiry:

        Begin with %<topic>s  and ask: "Why is this important?"
        Layered Exploration:

        For each answer, ask "Why?" four additional times.
        With each successive "Why?", dig deeper into the underlying reasons, motivations, or implications.
        Uncovering Insights:

        As you progress through the layers, take note of any emerging themes, connections, or surprising insights.
        Consider: How do these deeper insights reshape your understanding of %<topic>s ?
        Generating New Ideas:

        Reflect on the full chain of reasoning to identify innovative ideas or new perspectives that can be applied to %<topic>s .
        Use this methodical approach to reveal the deeper significance of %<topic>s  and inspire creative ideas from your exploration.
        ---
        please take into account the summary of the last round of brainstorming: %<last_round_summary>s
      PROMPT
    end
  end
end