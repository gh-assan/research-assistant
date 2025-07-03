### Task ID: 05
### Title: Integrate Memory into Agent's Decision Loop

**Description:**

Modify the `AgentManager` to make the agent's memory a core part of its operational loop. The agent should be able to read its memory at the beginning of each iteration and use that context to make more informed decisions about its next action.

**Acceptance Criteria:**

- [ ] The `AgentManager#run` loop loads the current memory state using the `MemoryManager` at the start of each iteration.
- [ ] The current memory state is passed to the `ActionDeterminer`.
- [ ] The `ActionDeterminer`'s prompt is updated to accept the current memory as context, allowing the LLM to make memory-aware decisions.

**Dependencies:**

- Task 04: Implement Memory Action Execution

**Files to be Created/Modified:**

- `lib/research_assistant/memory_agent/agent_manager.rb`
- `lib/research_assistant/memory_agent/action_determiner.rb`
