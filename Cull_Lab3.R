#MongoDB required library
library(mongolite)

# link to your database
my_collection<-mongo(collection = "summaries", db = "nps_theses")

####Examples####
# count the records
my_collection$count()

# get the first record
my_collection$iterate()$one()

# get a list of distinct items in the discipline feature
length(my_collection$distinct("discipline"))

# get record matching id = 858
my_collection$find('{"id":858}')

# pull down entire collection as dataframe
dataframe <- data.frame(my_collection$find())


####Task 1####
library(tm)
my.corpus <- Corpus(DirSource("/home/rstudio/Notebooks/Thesis_sample/"))
my.corpus_tok <- tm_map(my.corpus, removePunctuation)
my.corpus_stop <- tm_map(my.corpus, removeWords, stopwords("english"))
my.corpus_norm<- tm_map(my.corpus, content_transformer(tolower))
library(SnowballC)
my.corpus_stem<- tm_map(my.corpus, stemDocument)

matrix_tok <- TermDocumentMatrix(my.corpus_tok)
matrix_stop <- TermDocumentMatrix(my.corpus_stop)
matrix_norm <- TermDocumentMatrix(my.corpus_norm)
matrix_stem <- TermDocumentMatrix(my.corpus_stem)

data <- dataframe[1:50,]
sample.corpus <- Corpus(VectorSource(data$abstract))

sample.corpus_tok <- tm_map(sample.corpus, removePunctuation)
sample.corpus_stop <- tm_map(sample.corpus, removeWords, stopwords("english"))
sample.corpus_norm<- tm_map(sample.corpus, content_transformer(tolower))
sample.corpus_stem<- tm_map(sample.corpus, stemDocument)

Smatrix_tok <- TermDocumentMatrix(sample.corpus_tok)
Smatrix_stop <- TermDocumentMatrix(sample.corpus_stop)
Smatrix_norm <- TermDocumentMatrix(sample.corpus_norm)
Smatrix_stem <- TermDocumentMatrix(sample.corpus_stem)

library(text2vec)

jac_sim = sim2(Smatrix_norm, matrix_norm, method = "jaccard", norm = "none")








