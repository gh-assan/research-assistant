### Task ID: 08
### Title: Update `ActionDeterminer` SCHEME and Logic

**Description:**
Modify the `ActionDeterminer` to allow the LLM to return an array of actions instead of a single action. This involves updating the JSON `SCHEME` and adjusting the parsing logic in `get_next_action`. The LLM prompt will be updated to instruct it to return a list of actions.

**Acceptance Criteria:**
- [ ] The `SCHEME` constant in `ActionDeterminer` is updated to represent an array of action objects.
- [ ] The `get_next_action` method correctly parses the LLM's response, expecting an array of actions.
- [ ] The `get_next_action` method returns an array of `Action` objects.
- [ ] The `ActionDeterminer`'s prompt is updated to guide the LLM to output an array of actions, considering both memory and content-related tasks.

**Dependencies:**
- None

**Files to be Created/Modified:**
- `lib/research_assistant/memory_agent/action_determiner.rb`
