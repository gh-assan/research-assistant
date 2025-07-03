### Task ID: 10
### Title: Refine `ActionDeterminer` Prompt for Dual Actions

**Description:**
Further refine the prompt within `ActionDeterminer` to explicitly guide the LLM to consider and generate both memory-related actions and content-related actions within the same iteration. The prompt should encourage the LLM to think strategically about how these actions complement each other.

**Acceptance Criteria:**
- [ ] The `ActionDeterminer`'s prompt clearly instructs the LLM to output an array of actions.
- [ ] The prompt emphasizes the importance of using memory actions (`add_to_memory`, `update_memory`, `read_memory`) in conjunction with other content-focused actions.
- [ ] The prompt provides guidance on the typical flow or considerations for combining these action types.

**Dependencies:**
- Task 08

**Files to be Created/Modified:**
- `lib/research_assistant/memory_agent/action_determiner.rb`
