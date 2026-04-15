### Task ID: 25
### Title: Implement Hierarchical Concept Nesting

**Description:**

This task involves enabling concepts in the knowledge graph to contain sub-concepts, creating a hierarchical structure. For example, a "Machine Learning" node could have children like "Supervised Learning" and "Reinforcement Learning." This is important because it allows for multi-level abstraction and analysis. It mirrors how researchers naturally organize knowledge, from broad topics to specific sub-fields, enabling more powerful queries and a more intuitive representation of the knowledge domain.

**Acceptance Criteria:**

- [ ] The knowledge graph data structure is updated to support parent-child relationships between concept nodes.
- [ ] The `ConceptExtractor` is enhanced to identify and create these hierarchical links.
- [ ] The `KnowledgeGraph` class provides methods to traverse these hierarchies (e.g., get children, get parent).
- [ ] The graph visualization can represent these nested relationships, for instance, through expandable nodes or indented lists.

**Dependencies:**

- `lib/research_assistant/knowledge_base/knowledge_graph.rb`
- `lib/research_assistant/core_engine/concept_extractor.rb`

**Files to be Created/Modified:**

- `lib/research_assistant/knowledge_base/knowledge_graph.rb`
- `lib/research_assistant/core_engine/concept_extractor.rb`
- `spec/knowledge_base/knowledge_graph_spec.rb`
- `spec/core_engine/concept_extractor_spec.rb`
