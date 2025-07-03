### Task ID: 04
### Title: Implement Memory Action Execution

**Description:**

Write the business logic for executing the memory-related actions. The `AgentActionExecutor` will be updated to handle the new action types by calling the appropriate methods on the `MemoryManager`.

**Acceptance Criteria:**

- [ ] The `AgentActionExecutor#run` method has a case for the `add_to_memory` action, which calls the `MemoryManager` to add the data.
- [ ] The `AgentActionExecutor#run` method has a case for the `update_memory` action, which calls the `MemoryManager` to update existing data.
- [ ] The `AgentActionExecutor#run` method has a case for the `read_memory` action, which calls the `MemoryManager` to retrieve data.
- [ ] The executor returns the result of the memory operation (e.g., the content that was read, or a success status).

**Dependencies:**

- Task 02: Implement Memory Storage Mechanism
- Task 03: Define Memory-Related Actions

**Files to be Created/Modified:**

- `lib/research_assistant/memory_agent/agent_action_executor.rb`
