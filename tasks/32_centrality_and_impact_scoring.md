### Task ID: 32
### Title: Implement Centrality and Impact Scoring

**Description:**

This task is to periodically analyze the knowledge graph's structure to calculate a centrality or impact score for each node (e.g., using PageRank or simple degree centrality). This helps identify the most influential or foundational concepts within the research domain. It's important because it provides a data-driven way to guide focus, helping the researcher to quickly identify key areas, major themes, and potential bottlenecks in the knowledge base.

**Acceptance Criteria:**

- [ ] A new `GraphAnalyzer` module is created.
- [ ] This module can calculate a centrality score for each node in the graph.
- [ ] The score is stored as an attribute on each node.
- [ ] The system can rank and display nodes based on their impact score.
- [ ] The analysis can be run on demand.

**Dependencies:**

- `lib/research_assistant/knowledge_base/knowledge_graph.rb`

**Files to be Created/Modified:**

- `lib/research_assistant/knowledge_base/graph_analyzer.rb` (or extend existing one)
- `lib/research_assistant/knowledge_base/knowledge_graph.rb`
- `spec/knowledge_base/graph_analyzer_spec.rb`
