# layer-research
# Layered Research Assistant

Layered Research Assistant is a tool designed to facilitate iterative research processes. It includes various components for managing research data, generating questions, analyzing responses, and integrating knowledge.

## Features

- **Concept Extraction**: Extracts core concepts and relationships from a given topic.
- **Question Generation**: Generates research questions based on analysis.
- **Iteration Management**: Manages iterative research processes.
- **Response Analysis**: Analyzes responses to extract insights.
- **Knowledge Integration**: Integrates new knowledge into the existing analysis.
- **Output Generation**: Formats research outputs into different formats like Markdown, LaTeX, and HTML.
- **Validation**: Uses `dry-validation` schemas to validate various data structures.

## Installation

1. Clone the repository:
    ```sh
    git clone https://github.com/yourusername/layered-research.git
    cd layered-research
    ```

2. Install dependencies:
    ```sh
    bundle install
    ```

3. Configure settings:
    Update the [settings.yml](http://_vscodecontentref_/0) file with your configuration settings.

4. set up json model 
```shell
  ollama create research-assistant-json-model -f models/JsonModelfile
```

5. set up writer model
```shell
  ollama create research-assistant-writer-model -f models/WriterModelfile
```

6. set up reasoning model
```shell
  ollama create research-assistant-reasoning-model -f models/ReasoningModelfile
```


## Usage

### Command-Line Interface

You can initiate research processes using the command-line interface:

```sh
bin/research "sky is blue"