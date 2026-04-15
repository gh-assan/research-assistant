### Task ID: 30
### Title: Implement Inference Path Highlighting

**Description:**

This task is to develop a function that finds and highlights the shortest or most significant path between two seemingly unrelated nodes in the knowledge graph. This is a powerful feature for discovery, as it can uncover non-obvious, multi-step relationships that are not immediately apparent. It helps in generating novel hypotheses and understanding the hidden connections within the research data, essentially showing "how A connects to Z through B, C, and D."

**Acceptance Criteria:**

- [ ] The `KnowledgeGraph` class has a new method `find_path(node_a, node_b)`.
- [ ] This method implements a pathfinding algorithm (like Breadth-First Search) to find the shortest path.
- [ ] The method returns the sequence of nodes and edges that form the path.
- [ ] The output can be formatted to clearly display this path to the user.
- [ ] (Optional) The significance of a path can be scored based on relationship types or confidence scores.

**Dependencies:**

- `lib/research_assistant/knowledge_base/knowledge_graph.rb`

**Files to be Created/Modified:**

- `lib/research_assistant/knowledge_base/knowledge_graph.rb`
- `spec/knowledge_base/knowledge_graph_spec.rb`
