# News Topic Modeling with Latent Dirichlet Allocation (LDA)

**Portfolio owner:** Tousif Anam

An academic R-based exploratory NLP project for collecting and analyzing news articles with text preprocessing, term-frequency analysis and **unsupervised topic modeling** using LDA.

## Original project materials
The submitted project archive includes the original `IdsFinalProject.R` (~696 lines), raw and cleaned article CSVs, visualization images, a project summary, and an academic PDF report. The original archive reports:
- **10 articles** analyzed
- **4 topics** identified
- **243 cleaned words**

The figures above are **reported by the archived project summary**, not independently reproduced here.

## Stack
R · `tm` · `topicmodels` · `tidytext` · `dplyr` · `ggplot2` · `rvest` · `httr` · `wordcloud`

## Workflow
1. Collect articles from news pages (the original script targets The Daily Star).
2. Clean article text, tokenize, remove stop words, and construct a document–term matrix.
3. Fit an LDA model to discover latent topics.
4. Identify top terms, plot topic distributions, and generate word clouds.
5. Interpret findings and acknowledge the limitations of small samples.

## Getting started
An **adapted**, self-contained R entrypoint is provided as `analysis.R`. It reads an existing `data/Raw_Articles.csv` rather than scraping the web; this keeps exploratory runs independent of website changes. It has not been run or verified against the archived results.

Install required packages in R:
```r
install.packages(c("tm", "topicmodels", "ggplot2", "dplyr"))
```
Place the original `Raw_Articles.csv` in `data/`, confirm its text-column name, then run:
```sh
Rscript analysis.R
```

## Project status and limitations
- This repository contains an adapted script and documentation. Original project CSVs, visualizations, and PDF are **not yet uploaded**.
- The initial experiment uses only 10 articles. Topic stability and generalizability are limited.
- Web scraping depends on external page structure and must respect website policies.
- A larger dataset, fixed random seed, coherence-based topic selection, and reproducible outputs are useful next steps.

## Future improvements
- Import the original `IdsFinalProject.R`, CSVs and approved project figures.
- Add topic coherence/perplexity comparisons.
- Validate and document dataset provenance and cleaning decisions.
- Render a transparent results table and representative topic words.

*This is a portfolio summary of a project that was originally completed as academic group work. Listing Tousif Anam as the portfolio owner does not change original authorship.*
