## SARS-CoV-2 HaploGraph Specification

### 1. Purpose
- Visualize SARS-CoV-2 haplotype emergence and spread across Japanese prefectures.
- Provide lineage, trace, and genome-level context for epidemiological analysis.

### 2. Data Inputs
- **Haplotypes TSV**: fields `haplotype`, `first`, `last`, `duration`, `total`, `prefecture`.
- **Mutations JSON**: mutation lists per haplotype plus reference mutations.
- **Genome annotations JSON**: genome metadata and gene regions.
- **Districts JSON**: prefecture metadata (codes, labels, regions) used for Y-axis and filtering.

### 3. UI Structure
- **Navbar**
  - Dataset dropdown (`#dataset`) with multiple wave presets.
  - Haplotype multi-select (`#haplotype`) with “All” option.
  - Toggles: `Lineage`, `Trace`, `Duration`.
  - Resolution buttons (HD / 4K / 8K), language toggle (EN/JA), SVG download, help link.
- **Genome panel (`#genome`)**
  - Genome axis, labeled gene rectangles, reference mutations, haplotype mutations.
- **Chart panel (`#chart`)**
  - Prefecture rows, duration bars, first/last-day nodes, lineage links, trace paths.
- **Infobox** showing selected haplotype details (prefecture, first/last day, duration, total).

### 4. Rendering Flow
1. `setup()` initializes scales and loads districts, genome annotations, mutations, and haplotypes.
2. `initHaplotypes()` seeds `data.haplotypes.all/selected/visible/emerged`.
3. UI scaffolding (`prepareHTML`, axes, background area) is drawn once.
4. `drawAll()` executes whenever the visible haplotype set changes:
   - `drawGenome()` and `drawMutations()` rebuild genome visuals.
   - `drawLineage()`, `drawTrace()`, `drawHaplotype()` refresh main chart elements.
   - `updateVisibility()` toggles CSS classes according to active switches.
5. `updateGenome()` is reserved for resize events to redraw the genome section without touching chart traces.

### 5. Interaction & State
- **Dataset change**: updates file paths, reloads everything via `setup()`.
- **Haplotype selection**: multi-select control updates `selected`/`visible` sets; “All” resets to full list.
- **Brushing/Filtering**: date brush or prefecture click narrows `visible` haplotypes and triggers `drawAll()`.
- **Node click**: toggles focus on a specific haplotype (single-selection mode).
- **Lineage toggle**: shows/hides `.lineages`, `.lineage-parent`, `.lineage` elements; parents added dynamically in `drawLineage()` for context and tracked via `data.haplotypes.parents`.
- **Trace toggle**: shows/hides `.traces` and `.firstday.traced` without removing geometry.
- **Duration toggle**: shows/hides duration bars and last-day nodes.
- **Language toggle**: flips EN/JA, updates prefecture labels and help link, redraws Y-axis labels.
- **Resolution buttons**: swap canvas dimensions and rerun `setup()` to rebuild SVGs.
- **Download button**: injects styles into SVG and creates a blob URL for export.
- **Window resize**: triggers `updateGenome()` to re-layout the genome panel.

### 6. Visual Encoding
- **Duration bars**: colored per haplotype, width scaled by `log(total)`.
- **First/Last day nodes**: circles; `.emerged` vs `.traced` denote origin vs propagated observations.
- **Trace paths**: polylines following the same haplotype across prefectures.
- **Lineage links**: dashed connectors between inferred parent/child haplotypes; parent nodes inherit `.lineage-parent`.
- **Genome view**: gene rectangles (palette by region), reference mutations (diamonds), haplotype mutations (vertical line + circle pairs).

### 7. Styling & Classes
- `.show` / `.hide`: opacity toggles applied to SVG elements for fast visibility changes.
- `.lineage-parent`: marks injected parent nodes/traces so they can hide when lineage view is off.
- `.duration`, `.firstday`, `.lastday`, `.trace`, `.lineage`: key SVG classes for styling and toggling.

### 8. Constraints & Notes
- Parent haplotypes are inferred by stripping the suffix after the last dot in the child ID.
- Mutation data is expected for every haplotype; missing entries log an error to the console.
- Duration stroke width assumes totals > 1 due to logarithmic scaling.
- Multi-select instructions rely on Cmd/Ctrl + Click, reinforced via dropdown hint text.

