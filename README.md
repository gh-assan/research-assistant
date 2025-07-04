# Research Assistant

 Research Assistant is a tool designed to facilitate iterative research processes. It includes various components for managing research data, generating questions, analyzing responses, and integrating knowledge.

## Features

- **Concept Extraction**: Extracts core concepts and relationships from a given topic.
- **Question Generation**: Generates research questions based on analysis.
- **Iteration Management**: Manages iterative research processes.
- **Response Analysis**: Analyzes responses to extract insights.
- **Knowledge Integration**: Integrates new knowledge into the existing analysis.
- **Output Generation**: write the research output into the file system.

## Installation

1. Clone the repository:
    ```sh
    git clone https://github.com/gh-assan/research-assistant.git
    cd research-assistant
    ```

2. Install dependencies:
    ```sh
    bundle install
    ```

3. Install the Ollama CLI:
    ```sh
    install Olamma from https://ollama.com/
    ```

4. Set up the needed models:
    ```sh
    bin/create-models
    ```


## Usage

You can initiate research processes using the command-line interface:

```sh
bin/research "will AI take over developer role soon"
```

you can use the research agent by calling : 

```sh
bin/research-agent "will AI take over developer role soon"
```

## Memory Agent

The **Memory Agent** is responsible for memory-driven research prioritization and intelligent memory management throughout the research process.

### Key Features
- **Memory Prioritization**: Ranks and scores memories based on relevance, importance, and recency using a customizable scoring algorithm.
- **Task Queue Integration**: Dynamically prioritizes research actions using the most relevant memories.
- **Manual Adjustment**: (Planned) User interface for viewing and adjusting memory scores.
- **Research Goal Awareness**: Links memory prioritization to overarching research goals.
- **Robust Error Handling**: All memory agent operations are protected with custom error classes and detailed logging.

### Example Usage

The memory agent is invoked automatically as part of the research workflow, but can also be run directly:

```sh
bin/memory-agent "topic or research question"
```

### Error Handling
- All errors (including JSON parsing and API errors) are logged to `log/json_api_client.log`.
- Custom error classes are used for all major failure modes.

See the `architecture/ARCHITECTURE.md` for more details on the memory agent's design and integration.

## Error Handling and Logging

This project features robust error handling and logging for all API interactions:

- **Custom Error Classes**: All API and JSON parsing errors are raised as custom error classes (e.g., `JsonApiParseError`, `JsonApiResponseError`, `JsonApiConnectionError`).
- **Automatic Logging**: All errors are logged to `log/json_api_client.log` with timestamps, error type, message, and backtrace for easier debugging.
- **Safe Logging**: The log directory is automatically created if it does not exist.

If you encounter errors, check the log file for detailed diagnostics.


