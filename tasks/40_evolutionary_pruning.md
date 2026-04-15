### Task ID: 40
### Title: Implement Evolutionary Pruning of Knowledge Graph

**Description:**

This task involves implementing a system for "evolutionary pruning." As new information is added to the knowledge graph, this system will automatically identify and archive older, superseded relationships or nodes. The old data is not deleted but moved to an "archive" layer. This is important for maintaining the accuracy and relevance of the primary graph view, preventing it from becoming cluttered with outdated information while still preserving a complete historical record for longitudinal analysis.

**Acceptance Criteria:**

- [ ] The `KnowledgeGraph` can distinguish between "active" and "archived" entities.
- [ ] A `PruningAgent` is created to identify superseded information (e.g., a new fact that contradicts an old one with a lower confidence score).
- [ ] The agent can move these outdated entities to an archive file or state.
- [ ] By default, queries operate on the active graph, but there is an option to include the archive.

**Dependencies:**

- `lib/research_assistant/knowledge_base/knowledge_graph.rb`
- Task 23 (Confidence Scoring)
- Task 27 (Temporal Tracking)

**Files to be Created/Modified:**

- `lib/research_assistant/agent/pruning_agent.rb` (new file)
- `lib/research_assistant/knowledge_base/knowledge_graph.rb`
- `data/archive_graph.json` (example file)
- `spec/agent/pruning_agent_spec.rb`
