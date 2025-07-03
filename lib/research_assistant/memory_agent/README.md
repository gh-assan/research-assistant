# Memory Agent

## Overview

The Memory Agent is an autonomous agent designed to perform research and writing tasks while maintaining a persistent memory. Unlike standard agents that operate on a clean slate in each run, the Memory Agent can learn and recall information over time, allowing it to build a more coherent and context-aware understanding of a topic across multiple iterations and sessions.

Its memory is stored in a simple `memory.json` file, making it transparent and easy to inspect or modify.

## Features

- **Persistent Memory:** The agent's memory is saved to a `memory.json` file within its dedicated research directory. This allows the agent to retain information between runs.

- **Memory-Aware Decisions:** At each step of its process, the agent loads its memory and uses it as context to decide on the most appropriate next action. This prevents it from repeating work and allows it to build on previous findings.

- **Memory Manipulation Tools:** The agent has a specific set of tools to interact with its memory, controlled by the LLM's reasoning:
    - `add_to_memory`: Adds a new key-value pair to the memory. This is useful for storing new facts, insights, or conclusions.
    - `update_memory`: Modifies the value of an existing key. This allows the agent to refine or correct its previous knowledge.
    - `read_memory`: Retrieves the value associated with a key from memory. This allows the agent to use stored information in its content generation tasks.

### What to Store in Memory

The Memory Agent's effectiveness is greatly enhanced by strategically storing diverse types of information. Here are examples of what can be stored:

*   **Strategic Information:**
    *   `research_goals`: The overarching objectives of the research.
    *   `knowledge_gaps_identified`: Specific areas where information is missing or unclear.
    *   `hypotheses_formed`: Any theories or predictions being explored.
    *   `key_questions`: Important questions guiding the research.
    *   `progress_summary`: A brief overview of what has been achieved so far.

*   **Contextual Information:**
    *   `definitions`: Key terms and their definitions.
    *   `summaries`: Concise summaries of sections or the entire article.
    *   `counter_arguments`: Opposing viewpoints or evidence.
    *   `sources_cited`: Important references or URLs.
    *   `examples_used`: Illustrative examples from the article.

*   **Self-Reflection/Learning:**
    *   `what_worked_well`: Strategies or actions that yielded good results.
    *   `challenges_faced`: Difficulties encountered and how they were addressed.
    *   `learnings_from_iteration`: General insights gained about the research process itself.

## Usage

To run the Memory Agent, use the provided command-line script and pass a research topic as an argument:

```sh
bin/memory-agent "The future of renewable energy sources"
```

The agent will start its iterative process, and you will see its progress printed to the console.

## How It Works

The Memory Agent operates in a loop:

1.  **Load Memory:** At the beginning of each iteration, the agent reads the `memory.json` file to load its current state of knowledge.
2.  **Determine Action:** It analyzes the current article, its action history, and its memory to determine the best action to take next. This could be a standard research task (e.g., `extract_concepts`) or a memory operation (e.g., `add_to_memory`).
3.  **Execute Action:** The agent executes the chosen action. If it's a memory action, it modifies the `memory.json` file. If it's a research action, it generates new content.
4.  **Enhance Article:** The results of the action are used to refine and improve the main article.
5.  **Save State:** The updated article and a log of the action taken are saved in the current iteration's directory.
6.  **Repeat:** The loop continues until the termination condition (e.g., reaching the maximum number of iterations) is met.

## File Structure

All data for a Memory Agent run is stored in a unique directory:

```
data/research/<research_id>/
├── memory.json
└── iterations/
    ├── 1/
    │   ├── action.md
    │   ├── analysis_output.md
    │   └── article.md
    └── 2/
        └── ...
```

- **`memory.json`**: The central knowledge store for the agent. This file contains all the information the agent has decided to remember.
- **`iterations/`**: This directory contains a complete history of the agent's work, with a subdirectory for each step it took.
