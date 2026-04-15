### Task ID: 42
### Title: Implement Pattern & Anomaly Detection

**Description:**

This task is to develop a module that analyzes the graph's structure to find recurring patterns (e.g., "Concept A almost always causes Concept B") or structural anomalies (e.g., a concept with many incoming links but no outgoing ones). This is a meta-level analysis feature that can produce insights not about the data itself, but about the *structure* of the knowledge. It's important for identifying implicit rules, biases in the source data, or unique situations that warrant further investigation.

**Acceptance Criteria:**

- [ ] A `GraphPatternAnalyzer` module is created.
- [ ] It can detect and report on common relationship patterns (e.g., A -> B -> C chains).
- [ ] It can detect and report on structural anomalies (e.g., orphan nodes, nodes with imbalanced in/out degrees).
- [ ] The analysis can be run on demand and produces a human-readable report.

**Dependencies:**

- `lib/research_assistant/knowledge_base/knowledge_graph.rb`
- `lib/research_assistant/knowledge_base/graph_analyzer.rb`

**Files to be Created/Modified:**

- `lib/research_assistant/knowledge_base/graph_pattern_analyzer.rb` (new file)
- `spec/knowledge_base/graph_pattern_analyzer_spec.rb`
