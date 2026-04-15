### Task ID: 35
### Title: Implement Cross-Domain Link Suggester

**Description:**

This task involves creating a background agent that proactively searches for potential connections between concepts that are not yet directly linked but share second or third-degree neighbors. It would flag these as "potential cross-domain insights." This is highly valuable for fostering innovation, as it helps break down information silos and can surface unexpected connections between different fields of study present in the research data, leading to novel ideas.

**Acceptance Criteria:**

- [ ] A new background agent or module, `LinkSuggester`, is created.
- [ ] The agent can identify pairs of unlinked nodes that have a high degree of shared neighbors.
- [ ] It generates a list of these potential links, possibly with a score based on the strength of the indirect connection.
- [ ] The suggestions can be reviewed by the user via a CLI command.

**Dependencies:**

- `lib/research_assistant/knowledge_base/knowledge_graph.rb`
- `lib/research_assistant/agent/agent_manager.rb`

**Files to be Created/Modified:**

- `lib/research_assistant/agent/link_suggester.rb` (new file)
- `bin/research-agent` (to trigger the suggester)
- `spec/agent/link_suggester_spec.rb`
