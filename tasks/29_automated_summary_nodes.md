### Task ID: 29
### Title: Implement Automated Summary Nodes

**Description:**

This task involves creating a mechanism to automatically generate "Summary" nodes for highly connected "hub" nodes in the knowledge graph. These summary nodes will synthesize the information from all immediate neighbors of the hub. This is important for efficiency; instead of manually analyzing dozens of connections to understand a central topic, the user gets a quick, machine-generated overview. It helps in quickly grasping the essence of core concepts within the research domain.

**Acceptance Criteria:**

- [ ] A new module is created to identify hub nodes based on a connectivity threshold.
- [ ] This module can gather all direct neighbors of a hub node.
- [ ] It uses an LLM to generate a concise summary from the information of the neighboring nodes.
- [ ] The generated summary is stored in a new "Summary" node, linked to the hub node.
- [ ] This process can be triggered manually or run as a periodic background task.

**Dependencies:**

- `lib/research_assistant/knowledge_base/knowledge_graph.rb`
- `lib/research_assistant/output/summary_generator.rb`

**Files to be Created/Modified:**

- `lib/research_assistant/knowledge_base/graph_analyzer.rb` (new file)
- `lib/research_assistant/output/summary_generator.rb`
- `spec/knowledge_base/graph_analyzer_spec.rb`
