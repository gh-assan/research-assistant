### Task ID: 24
### Title: Implement Source Attribution and Evidence Snippets

**Description:**

This task focuses on enhancing the knowledge graph by storing a direct reference to the source file and the specific text snippet that generated every node and edge. This provides an "evidence trail" for every piece of information in the graph. It is critically important for research applications as it allows for instant verification, contextual understanding, and traceability of facts. It removes ambiguity and the need to manually hunt for the origin of a piece of data, thereby accelerating the research validation process.

**Acceptance Criteria:**

- [ ] The knowledge graph schema for nodes and edges is updated to include `source_file` (string) and `evidence_snippet` (string) attributes.
- [ ] The extraction engines (`ConceptExtractor`, `RelationsFinder`) are modified to capture and pass this information.
- [ ] The `KnowledgeGraph` class is updated to store and retrieve these new attributes.
- [ ] A new function is available to retrieve the evidence for a given node or edge.

**Dependencies:**

- `lib/research_assistant/knowledge_base/knowledge_graph.rb`
- `lib/research_assistant/core_engine/concept_extractor.rb`
- `lib/research_assistant/core_engine/relations_finder.rb`

**Files to be Created/Modified:**

- `lib/research_assistant/knowledge_base/knowledge_graph.rb`
- `lib/research_assistant/core_engine/concept_extractor.rb`
- `lib/research_assistant/core_engine/relations_finder.rb`
- `spec/knowledge_base/knowledge_graph_spec.rb`
