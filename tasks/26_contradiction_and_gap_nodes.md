### Task ID: 26
### Title: Implement Contradiction and Gap Nodes

**Description:**

This task introduces two new special node types into the knowledge graph: "Contradiction" and "Knowledge Gap." The system will automatically create these nodes when it identifies conflicting information or a missing logical link between related concepts. This is a crucial feature for research, as it transforms the knowledge graph from a passive repository of facts into an active tool that highlights areas needing further investigation. It explicitly points out inconsistencies and unanswered questions, directly guiding the research process.

**Acceptance Criteria:**

- [ ] The `KnowledgeGraph` schema is extended to support `Contradiction` and `KnowledgeGap` node types.
- [ ] A new module, `GapDetector`, is created to analyze the graph and identify these situations.
- [ ] The `GapDetector` can automatically create and link these special nodes at the appropriate points in the graph.
- [ ] The system can generate a report of all current contradiction and gap nodes.

**Dependencies:**

- `lib/research_assistant/knowledge_base/knowledge_graph.rb`
- `lib/research_assistant/core_engine/gap_detector.rb` (new file)

**Files to be Created/Modified:**

- `lib/research_assistant/knowledge_base/knowledge_graph.rb`
- `lib/research_assistant/core_engine/gap_detector.rb`
- `spec/knowledge_base/knowledge_graph_spec.rb`
- `spec/core_engine/gap_detector_spec.rb`
