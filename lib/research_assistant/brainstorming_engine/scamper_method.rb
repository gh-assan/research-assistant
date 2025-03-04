module ResearchAssistant
  module BrainstormingEngine
    class ScamperMethod < BaseBrainstorming

      PROMPT = <<~PROMPT
        Let's use the SCAMPER technique to uncover innovative ideas for %<topic>s . Consider the following guiding questions:

        Substitute: What components, materials, or processes could we swap out to improve or transform %<topic>s ?
        Combine: How might blending different ideas, functions, or features create a novel solution?
        Adapt: Which existing solutions or methods from other fields could be adapted to enhance %<topic>s ?
        Modify: In what ways can we alter, magnify, or minimize elements to refine our approach?
        Put to Another Use: How could we repurpose parts of %<topic>s  or use it in a new context?
        Eliminate: What elements could be removed or simplified to streamline the process?
        Reverse: Can reordering, inverting, or rethinking aspects of %<topic>s  lead to creative breakthroughs?
        Use these questions to spark fresh perspectives and generate diverse, actionable ideas for innovation around %<topic>s .
      PROMPT
    end
  end
end