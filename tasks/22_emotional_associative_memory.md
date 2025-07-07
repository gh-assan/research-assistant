### Task ID: 22
### Title: Implement Emotional/Associative Memory

**Description:**

This task focuses on expanding the agent's memory to include not just factual data, but also emotional and associative information. For many research tasks, especially in the humanities, social sciences, and creative fields, the ability to capture sentiment, subjective impressions, and speculative connections is crucial for generating novel insights.

The goal is to create a more "human-like" memory model that can handle ambiguity and creativity. By storing associations (e.g., "concept A reminds me of concept B"), sentiment (e.g., "this source has a pessimistic tone"), and speculative ideas, the agent can engage in more divergent thinking. This will allow it to explore unconventional research paths, generate more creative hypotheses, and produce articles that are not only factually accurate but also richer in tone and perspective.

**Acceptance Criteria:**

- [ ] The memory storage mechanism (currently `memory.json`) is updated to include a `type` field for each memory (e.g., `fact`, `association`, `sentiment`, `speculation`).
- [ ] The `Action` class in `lib/research_assistant/memory_agent/action.rb` is updated to handle these new memory types.
- [ ] The `AgentActionExecutor` is extended with actions to add these new types of memories (e.g., `add_association`, `add_sentiment`).
- [ ] The `ActionDeterminer` is modified to utilize these non-factual memories, particularly during brainstorming or when the research goal is exploratory.
- [ ] The `ArticleEnhancer` is updated to be able to use emotional/associative memories to influence the tone and style of the generated article.
- [ ] Unit tests are added to verify the agent's ability to handle and utilize emotional/associative memories.

**Dependencies:**

- None

**Files to be Created/Modified:**

- `lib/research_assistant/memory_agent/memory_manager.rb` (modify)
- `lib/research_assistant/memory_agent/action.rb` (modify)
- `lib/research_assistant/memory_agent/agent_action_executor.rb` (modify)
- `lib/research_assistant/memory_agent/action_determiner.rb` (modify)
- `lib/research_assistant/memory_agent/article_enhancer.rb` (modify)
- `spec/memory_agent/agent_manager_spec.rb` (modify)
