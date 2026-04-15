### Task ID: 33
### Title: Implement Query-Specific Subgraphs

**Description:**

This task involves creating a feature to generate temporary, focused subgraphs based on a user's query. Instead of viewing the entire, potentially overwhelming, knowledge graph, the user receives a clean, uncluttered view containing only the nodes and relationships relevant to their immediate investigation. This is important for usability and cognitive load. It allows the researcher to focus on a specific problem without distraction, making the exploration of complex topics much more manageable.

**Acceptance Criteria:**

- [ ] A new method `get_subgraph(query)` is added to the `KnowledgeGraph` or a manager class.
- [ ] The method uses the existing agent system or a search function to identify a set of seed nodes from the query.
- [ ] It then expands to include nodes within a certain distance (e.g., 1-2 hops away).
- [ ] The function returns a new, temporary `KnowledgeGraph` object containing only the relevant subset of data.
- [ ] The output can be visualized or listed as a standalone graph.

**Dependencies:**

- `lib/research_assistant/knowledge_base/knowledge_graph.rb`
- `lib/research_assistant/agent/agent_manager.rb`

**Files to be Created/Modified:**

- `lib/research_assistant/knowledge_base/knowledge_graph.rb`
- `lib/research_assistant/agent/action_determiner.rb` (to include a 'subgraph' action)
- `spec/knowledge_base/knowledge_graph_spec.rb`
