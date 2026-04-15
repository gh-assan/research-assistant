### Task ID: 27
### Title: Implement Temporal Tracking for Nodes and Edges

**Description:**

This task involves adding `created_at` and `updated_at` timestamps to all nodes and edges in the knowledge graph. This allows the system to track the evolution of the knowledge base over time. It is important because it helps identify which parts of the graph are based on older information, shows how the understanding of a topic has changed, and can be used to filter or prioritize information based on its age. This provides a dynamic, rather than static, view of the research landscape.

**Acceptance Criteria:**

- [ ] The knowledge graph schema for nodes and edges is updated to include `created_at` and `updated_at` timestamps.
- [ ] These timestamps are automatically set when nodes/edges are created or modified.
- [ ] The `KnowledgeGraph` class correctly manages these timestamps.
- [ ] It is possible to query the graph for information added or changed within a specific time window.

**Dependencies:**

- `lib/research_assistant/knowledge_base/knowledge_graph.rb`

**Files to be Created/Modified:**

- `lib/research_assistant/knowledge_base/knowledge_graph.rb`
- `spec/knowledge_base/knowledge_graph_spec.rb`
