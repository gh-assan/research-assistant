module ResearchAssistant
  module BrainstormingEngine
    class FutureVision < BaseBrainstorming

      PROMPT = <<~PROMPT
        Future Visioning for %<topic>s  in 2050

        Envision the End State:

        Imagine that by 2050, %<topic>s  has transformed the world.
        Describe the key features of this revolutionary future.
        Identify Key Milestones:

        What significant breakthroughs or changes made this transformation possible?
        List potential milestones and technological, social, or economic shifts.
        Trace the Evolution:

        Brainstorm the necessary steps and processes that led to this future.
        Consider the challenges overcome and the strategic decisions made along the way.
        Mapping the Journey:

        Outline a timeline of events, innovations, or policy changes that would cumulatively drive the transformation.
        Reflect on how each step interconnects to build towards the envisioned 2050 scenario.
        Use this detailed framework to explore a compelling and realistic future scenario for %<topic>s  while uncovering the journey required to achieve such groundbreaking changes.
        ---
        please take into account the summary of the last round of brainstorming: %<last_round_summary>s
      PROMPT
    end
  end
end