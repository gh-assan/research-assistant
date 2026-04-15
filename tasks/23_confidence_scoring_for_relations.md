### Task ID: 23
### Title: Implement Confidence Scoring for Knowledge Graph Relations

**Description:**

This task involves assigning a confidence score (e.g., 0.0-1.0) to each extracted relationship in the knowledge graph. The score will be determined by the extraction model, providing a quantitative measure of certainty for each fact. This is important because it allows the system and the user to distinguish between well-supported, high-confidence facts and more speculative or inferred connections. It enables more nuanced queries, improves the reliability of automated reasoning, and helps prioritize areas for manual verification.

**Acceptance Criteria:**

- [ ] The knowledge graph schema for relationships (edges) is updated to include a `confidence_score` attribute (float).
- [ ] The concept and relation extraction models are updated to output a confidence score along with each extracted relationship.
- [ ] The `KnowledgeGraph` class is updated to store and retrieve this confidence score.
- [ ] The output generators are modified to optionally display the confidence score when visualizing graph data.

**Dependencies:**

- `lib/research_assistant/knowledge_base/knowledge_graph.rb`
- `lib/research_assistant/core_engine/relations_finder.rb`
- `models/RelationsExtractionModelfile`

**Files to be Created/Modified:**

- `lib/research_assistant/knowledge_base/knowledge_graph.rb`
- `lib/research_assistant/core_engine/relations_finder.rb`
- `models/RelationsExtractionModelfile`
- `spec/knowledge_base/knowledge_graph_spec.rb`
