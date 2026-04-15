### Task ID: 36
### Title: Implement Visual Density Maps

**Description:**

This task is to generate a text-based visual representation of a "density map" of the knowledge graph. This map would show clusters of high activity (many interconnected nodes) and "knowledge deserts" (areas with sparse connections). This is important for providing a high-level overview of the research landscape, allowing the user to see at a glance where information is concentrated and where more research is needed. It's a diagnostic tool for the health and completeness of the knowledge base.

**Acceptance Criteria:**

- [ ] A new `DensityMapGenerator` module is created.
- [ ] It analyzes the graph to identify clusters and sparse areas (e.g., using a grid-based approach on a 2D projection of the graph).
- [ ] It generates a text-based (or simple graphical) output representing these densities.
- [ ] The map can be displayed in the terminal.

**Dependencies:**

- `lib/research_assistant/knowledge_base/knowledge_graph.rb`
- `lib/research_assistant/output/output_generator.rb`

**Files to be Created/Modified:**

- `lib/research_assistant/output/density_map_generator.rb` (new file)
- `spec/output/density_map_generator_spec.rb`
