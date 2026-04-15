### Task ID: 37
### Title: Implement Personalized Research Pathways

**Description:**

This task involves creating a feature that, based on a user's query history, proposes a "learning pathway" through the knowledge graph. This would be a sequence of nodes to explore, ordered to build understanding from foundational concepts to more advanced ones. This is important for users who are new to a topic within the research data. It provides a guided, structured way to learn, preventing them from getting lost and ensuring they build a solid foundation of knowledge.

**Acceptance Criteria:**

- [ ] The system logs user queries or accessed nodes.
- [ ] A `PathwayGenerator` module is created that takes a topic and user history as input.
- [ ] It analyzes the graph to find a logical path from known (previously accessed) nodes to the target topic.
- [ ] The pathway is presented to the user as an ordered list of concepts to explore.

**Dependencies:**

- `lib/research_assistant/knowledge_base/knowledge_graph.rb`
- `log/user_activity.log` (new file or mechanism)

**Files to be Created/Modified:**

- `lib/research_assistant/agent/pathway_generator.rb` (new file)
- `bin/research-agent`
- `spec/agent/pathway_generator_spec.rb`
