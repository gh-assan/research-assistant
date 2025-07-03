### Task ID: 03
### Title: Define Memory-Related Actions

**Description:**

Define the specific actions the agent can take to interact with its memory. This involves updating the `ActionDeterminer` to recognize and suggest actions like `add_to_memory`, `update_memory`, and `read_memory`. The prompts used by the `ActionDeterminer` will be updated to include these new tools in its list of possible actions.

**Acceptance Criteria:**

- [ ] The `ActionDeterminer`'s prompt is updated to include the new memory tools (`add_to_memory`, `update_memory`, `read_memory`) in its description of available actions.
- [ ] The system can correctly parse an LLM response that suggests one of the new memory actions.
- [ ] The `Action` class is capable of representing these new actions and their parameters (e.g., `action: 'add_to_memory', key: 'new_idea', value: '...'`)

**Dependencies:**

- Task 01: Scaffold Memory Agent Module

**Files to be Created/Modified:**

- `lib/research_assistant/memory_agent/action_determiner.rb`
- `lib/research_assistant/memory_agent/action.rb`
