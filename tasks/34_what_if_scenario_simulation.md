### Task ID: 34
### Title: Implement "What-If" Scenario Simulation

**Description:**

This task is to allow a user to temporarily add a hypothetical node or relationship to the knowledge graph (e.g., "What if we prove 'Concept A' is linked to 'Concept B'?"). The system would then use its reasoning capabilities to infer and display potential consequences or new paths based on this hypothetical addition. This is a powerful creative tool for researchers, enabling them to explore the potential impact of future discoveries and formulate new hypotheses in a sandboxed environment without permanently altering the main graph.

**Acceptance Criteria:**

- [ ] A `simulate_what_if(hypothetical_data)` method is created.
- [ ] This method creates a temporary, in-memory copy of the knowledge graph.
- [ ] It adds the hypothetical node/edge to this temporary graph.
- [ ] It runs an inference or pathfinding process on the temporary graph to find new connections.
- [ ] The results of the simulation (e.g., new paths) are displayed to the user. The temporary graph is then discarded.

**Dependencies:**

- `lib/research_assistant/knowledge_base/knowledge_graph.rb`
- `lib/research_assistant/core_engine/relations_finder.rb` (for inference)

**Files to be Created/Modified:**

- `lib/research_assistant/knowledge_base/knowledge_graph.rb`
- `bin/brainstorm` (or similar CLI)
- `spec/knowledge_base/knowledge_graph_spec.rb`
