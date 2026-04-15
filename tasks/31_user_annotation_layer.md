### Task ID: 31
### Title: Implement User Annotation and Correction Layer

**Description:**

This task involves creating a mechanism for users to manually add, remove, or modify nodes and edges in the knowledge graph. These user-provided changes will be stored in a separate but merged layer. This is crucial for accuracy and user control. No automated system is perfect, and allowing for manual correction ensures the graph remains a reliable source of truth. It also allows the user to add their own insights and steer the focus of the graph, making it a collaborative tool.

**Acceptance Criteria:**

- [ ] The `KnowledgeGraph` can source data from both the AI-generated graph and a new user-annotations file.
- [ ] CLI commands are created to `add-node`, `add-edge`, `remove-node`, `remove-edge`.
- [ ] User modifications are saved to a separate, human-readable file (e.g., `user_graph.json`).
- [ ] When the graph is loaded, the user annotations are applied as overrides to the AI-generated graph.

**Dependencies:**

- `lib/research_assistant/knowledge_base/knowledge_graph.rb`
- `lib/research_assistant/knowledge_base/file_manager.rb`

**Files to be Created/Modified:**

- `lib/research_assistant/knowledge_base/knowledge_graph.rb`
- `lib/research_assistant/knowledge_base/user_annotations.rb` (new file)
- `bin/brainstorm` (or a new CLI entry point)
- `data/user_graph.json` (example file)
