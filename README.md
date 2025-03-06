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

4. Set up JSON model:
    ```sh
    ollama create research-assistant-json-model -f models/JsonModelfile
    ```

5. Set up writer model:
    ```sh
    ollama create research-assistant-writer-model -f models/WriterModelfile
    ```

6. Set up reasoning model:
    ```sh
    ollama create research-assistant-reasoning-model -f models/ReasoningModelfile
    ```
6. Set up brainstorming  model:
    ```sh
    ollama create research-assistant-brainstorming-model -f models/BrainstormingModelfile
    ```


## Usage

You can initiate research processes using the command-line interface:

```sh
bin/research "will AI take over developer role soon"
```

## Components

### Concept Extraction
The ConceptExtractor module extracts key concepts and relationships from a given topic. It uses natural language processing techniques to identify and categorize important concepts.

### Question Generation
The QuestionEngine module generates research questions based on the analysis of the provided text. It helps in identifying gaps and areas that require further investigation.

### Iteration Management
The IterationManager module manages the iterative research process. It integrates new knowledge, generates articles, and saves iteration data.

### Response Analysis
The InsightsExtractor module analyzes responses to extract insights. It categorizes insights based on their significance and relevance to the topic.

### Knowledge Integration
The KnowledgeIntegrator module integrates new knowledge into the existing analysis. It combines insights, concepts, gaps, questions, and relationships to form a comprehensive understanding.

### Output Generation
The OutputGenerator module will write the generated article into the file system, each iteration data will be written into a new folder.

