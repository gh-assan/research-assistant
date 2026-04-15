### Task ID: 28
### Title: Implement Dynamic Relationship Typing

**Description:**

This task focuses on moving beyond generic "related_to" links by using the LLM to define the *type* of relationship between concepts (e.g., "causes," "is_a_subset_of," "antagonistic_to"). This adds a rich semantic layer to the graph, enabling much more precise queries and deeper analysis. It's a critical step in transforming the graph from a simple network of concepts into a true model of the knowledge domain, allowing for more sophisticated reasoning and insight generation.

**Acceptance Criteria:**

- [ ] The `RelationsFinder` model is updated to extract a relationship *type* in addition to the linked concepts.
- [ ] The knowledge graph edge schema is updated to store this `relationship_type` string.
- [ ] The `KnowledgeGraph` class can store, retrieve, and filter edges based on their type.
- [ ] The system can answer queries like "What concepts does 'X' cause?"

**Dependencies:**

- `lib/research_assistant/core_engine/relations_finder.rb`
- `models/RelationsExtractionModelfile`
- `lib/research_assistant/knowledge_base/knowledge_graph.rb`

**Files to be Created/Modified:**

- `lib/research_assistant/core_engine/relations_finder.rb`
- `models/RelationsExtractionModelfile`
- `lib/research_assistant/knowledge_base/knowledge_graph.rb`
- `spec/core_engine/relations_finder_spec.rb`
