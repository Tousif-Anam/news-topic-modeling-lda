# News Topic Modeling with LDA — adapted R analysis
# Portfolio: Tousif Anam
# Reconstructed as a reproducible entrypoint from the supplied academic project.
# Not a verbatim copy of original IdsFinalProject.R; results are not verified.
suppressPackageStartupMessages({
  library(tm)
  library(topicmodels)
  library(ggplot2)
  library(dplyr)
})
set.seed(42)
input_path <- "data/Raw_Articles.csv"
if (!file.exists(input_path)) {
  stop("Missing data/Raw_Articles.csv — copy it from your original project archive.")
}
articles <- read.csv(input_path, stringsAsFactors = FALSE, check.names = FALSE)
# Inspect columns because the original source schema is not fixed here.
candidate_columns <- c("content", "Content", "text", "Text", "article", "Article", "body", "Body", "description")
text_col <- intersect(candidate_columns, names(articles))[1]
if (is.na(text_col)) {
  stop(paste("No recognized article text column. Columns:", paste(names(articles), collapse=", ")))
}
texts <- trimws(as.character(articles[[text_col]]))
texts <- texts[!is.na(texts) & nchar(texts) > 0L]
if (length(texts) < 5L) stop("At least five non-empty texts are required for this demonstration.")
corpus <- VCorpus(VectorSource(texts))
corpus <- tm_map(corpus, content_transformer(tolower))
corpus <- tm_map(corpus, removePunctuation)
corpus <- tm_map(corpus, removeNumbers)
corpus <- tm_map(corpus, removeWords, stopwords("english"))
corpus <- tm_map(corpus, stripWhitespace)
dtm <- DocumentTermMatrix(corpus, control = list(wordLengths=c(3, Inf)))
dtm <- removeSparseTerms(dtm, 0.99)
nonempty <- slam::row_sums(dtm) > 0
dtm <- dtm[nonempty, ]
if (nrow(dtm) < 4L || ncol(dtm) < 4L) stop("Not enough terms/documents after preprocessing.")
k <- min(4L, nrow(dtm) - 1L)
model <- LDA(dtm, k=k, method="Gibbs",
             control=list(seed=42, burnin=200, iter=1000, thin=50))
print(terms(model, 10))
topics <- posterior(model)$topics
dominant <- max.col(topics, ties.method="first")
distribution <- as.data.frame(table(topic=factor(dominant, levels=seq_len(k))))
print(distribution)
dir.create("results", showWarnings=FALSE)
write.csv(data.frame(document=which(nonempty), dominant_topic=dominant, topics),
          "results/document_topics.csv", row.names=FALSE)
plot <- ggplot(distribution, aes(x=topic, y=Freq)) +
  geom_col() + labs(title="Dominant LDA Topics", x="Topic", y="Documents")
ggsave("results/topic_distribution.png", plot=plot, width=7, height=4, dpi=150)
cat("Finished adapted LDA analysis. This does not reproduce original metrics.\n")
