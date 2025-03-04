module ResearchAssistant
  module BrainstormingEngine
    class ReverseBrainstorming < BaseBrainstorming

      PROMPT = <<~PROMPT
        Reverse Brainstorming for Innovation on %<topic>s 

        Initial Brainstorming:

        Generate a list of the worst or most impractical ideas related to %<topic>s .
        Aim for ideas that, on the surface, seem absurd, unfeasible, or counterproductive.
        Analysis of 'Bad' Ideas:

        Examine each idea to identify underlying assumptions, unexpected angles, or hidden insights.
        Consider what makes these ideas "bad" and whether reversing or adapting those elements could offer a fresh perspective.
        Idea Transformation:

        Look for opportunities where the negatives can be flipped into positives.
        Ask: How can the aspects of these terrible ideas be reimagined into innovative, useful solutions?
        Synthesize and Reflect:

        Discuss which transformed ideas hold potential for further exploration or real-world application.
        Reflect on how thinking in extremes has revealed new possibilities around %<topic>s .
      PROMPT
    end
  end
end