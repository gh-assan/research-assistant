# Architecture

This document outlines the architecture of the Research Assistant project, a command-line tool designed to automate and assist in iterative research tasks using Large Language Models (LLMs) through Ollama.

## 1. High-Level Overview

The Research Assistant is a Ruby-based application that takes a research topic as input and performs a series of steps to explore the topic, generate content, and refine it over multiple iterations. It operates in two primary modes: a structured, iterative research process and a more autonomous "agent-based" process.

The system is designed with a modular architecture, separating concerns into distinct components:

- **Entry Points (CLI):** User-facing scripts that initiate research tasks.
- **Configuration:** A centralized module for managing application settings.
- **Ollama Interface:** A dedicated layer for communicating with the Ollama LLM service.
- **Core Engine:** Orchestrates the main, structured research workflow.
- **Agent Engine:** Manages the autonomous, action-driven research workflow.
- **Brainstorming Engine**: A collection of modules to generate ideas using different creative techniques.
- **Review Engine**: A component for reviewing and refining generated content.
- **Story Agent**: An autonomous agent dedicated to writing and enhancing narrative stories.
- **Knowledge Base:** Handles the storage and retrieval of all research-related data.

## 2. Technology Stack

- **Language:** Ruby
- **Key Gems:**
  - `faraday`: For making HTTP requests to the Ollama API.
  - `dry-validation`: For schema validation (likely for API responses or configuration).
  - `smart_properties`: For defining expressive and flexible object attributes.
  - `zeitwerk`: For efficient, modern code loading.
  - `rspec`: For testing.
- **LLM Service:** [Ollama](https://ollama.com/) is used to run various LLMs locally.

## 3. Architectural Components

### 3.1. Entry Points (`bin/`)

The `bin/` directory contains the command-line executables that serve as the primary user interface.

- **`bin/research`**: Initiates the structured, iterative research process managed by the `CoreEngine`.
- **`bin/research-agent`**: Initiates the autonomous agent-based research process managed by the `AgentEngine`.
- **`bin/stories-agent`**: Initiates the autonomous story-writing process managed by the `StoryAgent`.
- **`bin/brainstorm`**: Likely initiates a brainstorming session using the `BrainstormingEngine`.
- **`bin/review`**: Likely uses the `ReviewEngine` to critique a piece of text.
- **`bin/create-models`**: A utility script to set up the required LLM models in Ollama.

### 3.2. Configuration (`lib/research_assistant.rb`)

A singleton `Configuration` class provides global access to application settings. It loads configuration from environment variables (`.env` file) and provides sensible defaults. This includes:

- Ollama API endpoint (`OLLAMA_URL`)
- Model names for different tasks (reasoning, writing, JSON extraction, brainstorming, etc.)
- Directory paths for storing data (`RESEARCH_DIR`, `STORY_DIR`)
- Iteration limits (`MAX_ITERATIONS`, `MAX_AGENT_ITERATIONS`)

### 3.3. Ollama Interface (`lib/research_assistant/ollama_interface/`)

This component abstracts all communication with the Ollama API.

- **`ApiClient`**: A base class that handles the core logic of sending a prompt to the Ollama `/api/generate` endpoint.
- **Specialized Clients** (`ReasoningClient`, `JsonApiClient`, `WriterApiClient`, `BrainstormingClient`, `ReviewClient`, etc.): These classes inherit from `ApiClient` and are configured to use specific LLM models tailored for different tasks.

### 3.4. Core Engine (`lib/research_assistant/core_engine/`)

The Core Engine drives the primary, structured research workflow. It follows a predefined sequence of steps in a loop.

- **`IterationManager`**: The central orchestrator. It runs a loop for a fixed number of iterations, performing tasks like concept extraction, question generation, and knowledge integration.

### 3.5. Agent Engine (`lib/research_assistant/agent/`)

The Agent Engine provides a dynamic and autonomous research process.

- **`AgentManager`**: The main orchestrator for the agent. It runs a loop until a termination condition is met.
- **`ActionDeterminer`**: At each step, this component analyzes the current state of the research article and determines the next best `action` to take.
- **`AgentActionExecutor`**: Executes the determined action.
- **`ArticleEnhancer`**: Integrates the result of the action back into the main article.

### 3.6. Brainstorming Engine (`lib/research_assistant/brainstorming_engine/`)

This engine is dedicated to idea generation. It is composed of multiple modules, each implementing a different brainstorming technique.

- **`BaseBrainstorming`**: A base class that takes a topic and runs a prompt against the `BrainstormingClient`.
- **Technique Modules** (`DeepDive`, `FutureVision`, `MindMapping`, `ReverseBrainstorming`, `ScamperMethod`, etc.): Each of these classes inherits from `BaseBrainstorming` and defines a specific `PROMPT` that guides the LLM to brainstorm in a particular way.

### 3.7. Review Engine (`lib/research_assistant/review_engine/`)

This component is focused on content quality and refinement.

- **`Reviewer`**: Takes an article, sends it to the `ReviewClient`, and receives a critique or review.
- **`Refiner`**: Likely takes an article and a set of review comments and uses an LLM to refine the article based on the feedback.

### 3.8. Story Agent (`lib/research_assistant/story_agent/`)

This is a specialized version of the Agent Engine, tailored specifically for creative writing and narrative development.

- **`AgentManager`**: Similar to the research agent, it orchestrates the story-writing process.
- **`ActionDeterminer`**: Decides on the next narrative step (e.g., "develop a character," "introduce a plot twist," "describe the setting").
- **`StoryEnhancer`**: Integrates the output of the action into the evolving story.
- **Persistence**: It uses its own `FileManager` to save story iterations to the `data/story/` directory.

### 3.9. Knowledge Base (`lib/research_assistant/knowledge_base/`)

This component is responsible for the persistence of all generated data.

- **`FileManager`**: Provides an abstraction for file operations, creating unique directories for each research run (`research_id`) or story run (`story_id`).
- **Directory Structure**: It saves all artifacts from the research and story generation processes into iteration-specific subdirectories, ensuring a complete record of the process.

## 4. Data Flow

The data flow remains largely the same as described previously, but can be initiated by different entry points (`bin/research`, `bin/research-agent`, `bin/stories-agent`, etc.) that activate their corresponding engines. Each engine then follows its internal logic, using the **Ollama Interface** to communicate with LLMs and the **Knowledge Base** to persist its results.

## 5. Design Decisions

- **Modularity and Separation of Concerns**: The architecture is highly modular. Each engine (`Core`, `Agent`, `Brainstorming`, `Review`, `Story`) has a distinct responsibility, making the system clean and extensible.
- **Configuration over Code**: The use of a global configuration object allows for easy tuning of the system without code changes.
- **Specialized LLM Clients**: The use of different clients for different tasks is a key design strength, enabling the use of the best model for each specific job (e.g., a creative model for brainstorming, a critical model for reviewing).
- **Iterative Refinement**: This core principle is applied across all engines, not just research. Stories and ideas are also built and improved iteratively.
- **Stateful Persistence**: Every major process saves its state. This is crucial for long-running tasks, enabling auditability and potential resumption from failure.
- **Agent-Based Autonomy**: The move towards agent-based systems (`AgentEngine`, `StoryAgent`) represents a sophisticated architectural pattern that allows for more flexible, intelligent, and goal-oriented automation.
- **Prompt-Driven Logic**: Much of the application's logic is encoded in the `PROMPT` constants within different modules. This makes it easy to change the behavior of an engine by simply modifying the prompt, without altering the Ruby code.
- **Dedicated Models for Specialized Tasks**: To ensure high-quality, efficient, and predictable behavior, any new component (like an agent or a specialized engine) that performs a distinct reasoning task should have its own dedicated Ollama model, defined in a corresponding `Modelfile`. This includes creating a new model file, adding it to the `bin/create-models` script, and adding a new configuration entry to `lib/research_assistant.rb`.