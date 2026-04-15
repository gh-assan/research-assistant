### Task ID: 38
### Title: Implement "Forgotten" Node Rediscovery

**Description:**

This task is to implement a mechanism that periodically surfaces nodes that haven't been accessed or updated in a long time but are connected to recently active areas of the graph. This feature helps prevent valuable, older insights from being buried and forgotten. It's important because it can spark new ideas by reintroducing old concepts in the context of new research, potentially revealing their newfound relevance.

**Acceptance Criteria:**

- [ ] Nodes in the graph have a `last_accessed_at` timestamp, updated on access.
- [ ] A `RediscoveryAgent` is created to perform the analysis.
- [ ] The agent identifies nodes that are "old" (low `last_accessed_at`) but are neighbors of "new" nodes (high `last_accessed_at`).
- [ ] It generates a report of these "forgotten but relevant" nodes for the user to review.

**Dependencies:**

- `lib/research_assistant/knowledge_base/knowledge_graph.rb` (with `last_accessed_at` timestamp)
- Task 27 (Temporal Tracking)

**Files to be Created/Modified:**

- `lib/research_assistant/agent/rediscovery_agent.rb` (new file)
- `lib/research_assistant/knowledge_base/knowledge_graph.rb`
- `spec/agent/rediscovery_agent_spec.rb`
