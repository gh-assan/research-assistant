### Task ID: 41
### Title: Implement Question-Driven Expansion

**Description:**

This task will modify the system so that when a user asks a question that the knowledge graph cannot answer, it automatically creates a new "Question" node. This node is then intelligently linked to the most relevant existing concepts in the graph. This feature transforms user queries from one-off interactions into a persistent part of the knowledge base itself. It's important because it creates an explicit, self-organizing map of the current boundaries of the system's knowledge, providing a clear and actionable roadmap for future research and data ingestion.

**Acceptance Criteria:**

- [ ] When a query yields no satisfactory answer, the system identifies it as an "unanswered question."
- [ ] A new node of type `Question` is created with the text of the query.
- [ ] The system identifies the key concepts in the question and links the new `Question` node to them in the graph.
- [ ] A command is available to list all open "Question" nodes, effectively creating a research to-do list.

**Dependencies:**

- `lib/research_assistant/agent/agent_manager.rb`
- `lib/research_assistant/knowledge_base/knowledge_graph.rb`

**Files to be Created/Modified:**

- `lib/research_assistant/agent/action_determiner.rb`
- `lib/research_assistant/knowledge_base/knowledge_graph.rb`
- `spec/agent/agent_manager_spec.rb`
