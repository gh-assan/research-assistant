### Task ID: 39
### Title: Implement Argument & Thesis Builder

**Description:**

This task allows a user to select a set of nodes and have the system attempt to structure them into a coherent argument or thesis outline. The system would use the defined relationship types (e.g., "causes," "supports," "contradicts") to build a logical flow. This is a powerful research assistant feature that directly aids in the writing process. It helps organize thoughts, structure papers, and move from a cloud of concepts to a structured narrative.

**Acceptance Criteria:**

- [ ] A new CLI command `build-argument` is created.
- [ ] The user can provide a list of concept names as input.
- [ ] An `ArgumentBuilder` module retrieves the subgraph connecting these concepts.
- [ ] It analyzes the relationship types to create a logical outline (e.g., using indentation or bullet points).
- [ ] The resulting outline is printed to the console.

**Dependencies:**

- `lib/research_assistant/knowledge_base/knowledge_graph.rb`
- Task 28 (Dynamic Relationship Typing)

**Files to be Created/Modified:**

- `lib/research_assistant/output/argument_builder.rb` (new file)
- `bin/research`
- `spec/output/argument_builder_spec.rb`
