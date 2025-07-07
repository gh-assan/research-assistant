### Task ID: 21
### Title: Implement Hierarchical Memory & Knowledge Graph

**Description:**

This task involves transitioning the Memory Agent from a flat key-value memory store to a more sophisticated hierarchical structure using a knowledge graph. This will enable the agent to understand and represent relationships between different pieces of information, such as "concept A is a type of concept B" or "finding X contradicts finding Y."

The core idea is to move beyond simple fact retrieval and empower the agent with a deeper, more contextual understanding of the research domain. By representing knowledge as a graph, the agent can traverse relationships, infer connections, and identify complex patterns that are impossible to see with a simple list of memories. This will significantly enhance the quality of its reasoning, leading to more insightful analysis, better research questions, and more coherent article generation.

**Acceptance Criteria:**

- [ ] A new `KnowledgeGraph` class is created within the `lib/research_assistant/knowledge_base/` directory.
- [ ] The `KnowledgeGraph` class can add, retrieve, and remove nodes (concepts) and edges (relationships).
- [ ] The `MemoryManager` is updated to use the `KnowledgeGraph` as its primary data store.
- [ ] The `AgentActionExecutor` is modified to have actions for adding and querying relationships in the knowledge graph (e.g., `add_relationship`, `find_related_concepts`).
- [ ] The `ActionDeterminer` is updated to leverage the knowledge graph when deciding on the next action, allowing it to explore conceptual connections.
- [ ] Unit tests for the `KnowledgeGraph` class are added to `spec/knowledge_base/`.
- [ ] Existing tests for the `MemoryManager` and `AgentManager` are updated to reflect the new data structure.

**Dependencies:**

- A graph library (e.g., `rgl`) may need to be added to the `Gemfile`, or a custom graph implementation must be built.

**Files to be Created/Modified:**

- `lib/research_assistant/knowledge_base/knowledge_graph.rb` (new)
- `spec/knowledge_base/knowledge_graph_spec.rb` (new)
- `lib/research_assistant/memory_agent/memory_manager.rb` (modify)
- `lib/research_assistant/memory_agent/agent_action_executor.rb` (modify)
- `lib/research_assistant/memory_agent/action_determiner.rb` (modify)
- `spec/memory_agent/memory_manager_spec.rb` (modify)
- `spec/memory_agent/agent_manager_spec.rb` (modify)
- `Gemfile` (potentially modify)
