module ResearchAssistant
  module BrainstormingEngine
    class MultiPersonals < BaseBrainstorming

      PROMPT = <<~PROMPT
        Simulate a high-stakes brainstorming competition featuring five intellectually competitive AI agents. Their objective: 
        to generate the most diverse and thought-provoking ideas on the 
        topic— %<topic>s 
        -----------------------------------------
        The agent contributing the highest number of unique and meaningful insights wins.
        Each agent should approach the discussion from a distinct perspective—psychological, sociological, philosophical, historical, and neuroscientific—bringing depth and contrast to the conversation. 
        They should not only generate ideas but also challenge, refine, and expand upon each other's contributions, fostering an evolving discussion.
        The session should unfold dynamically, mirroring a real brainstorming debate, where ideas spark counterarguments, clarifications, and new lines of thought. 
        Continue the discussion through multiple iterations (at least 5), ensuring agents push the limits of their reasoning until no further novel ideas can be generated.
        Present the session as an engaging, structured dialogue, capturing the energy of competitive intellectual exploration.
      PROMPT
    end
  end
end