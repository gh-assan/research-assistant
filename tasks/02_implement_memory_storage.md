### Task ID: 02
### Title: Implement Memory Storage Mechanism

**Description:**

Implement the logic for the agent to persist and retrieve its memory. This will involve creating a dedicated `MemoryManager` class that handles reading from and writing to a `memory.json` file within the agent's specific run directory.

**Acceptance Criteria:**

- [ ] A new class `lib/research_assistant/memory_agent/memory_manager.rb` is created.
- [ ] The `MemoryManager` can initialize the memory file (`memory.json`) with a default structure (e.g., an empty array or hash).
- [ ] The `MemoryManager` has a `read` method that returns the parsed content of `memory.json`.
- [ ] The `MemoryManager` has a `write` method that saves a Ruby object (Hash or Array) to `memory.json` in a pretty-printed JSON format.

**Dependencies:**

- Task 01: Scaffold Memory Agent Module

**Files to be Created/Modified:**

- `lib/research_assistant/memory_agent/memory_manager.rb`
- `lib/research_assistant/memory_agent/file_manager.rb` (to coordinate with the new manager)
