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


