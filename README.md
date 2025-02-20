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
    git clone https://github.com/yourusername/layered-research.git
    cd layered-research
    ```

2. Install dependencies:
    ```sh
    bundle install
    ```

3. Set up JSON model:
    ```sh
    ollama create research-assistant-json-model -f models/JsonModelfile
    ```

4. Set up writer model:
    ```sh
    ollama create research-assistant-writer-model -f models/WriterModelfile
    ```

5. Set up reasoning model:
    ```sh
    ollama create research-assistant-reasoning-model -f models/ReasoningModelfile
    ```

## Usage

You can initiate research processes using the command-line interface:

```sh
bin/research "sky is blue"
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
The OutputGenerator module formats research outputs into different formats like Markdown, LaTeX, and HTML. It ensures that the generated content is well-structured and readable.


## Contributing

Contributions are welcome! Please follow these steps to contribute:

1. Fork the repository.
2. Create a new branch for your feature or bugfix.
3. Make your changes and commit them with a descriptive message.
4. Push your changes to your fork.
5. Create a pull request to the main repository.

## License

This project is licensed under the MIT License. See the `LICENSE` file for details.

## Acknowledgements

We would like to thank all the contributors and the open-source community for their support and contributions to this project.