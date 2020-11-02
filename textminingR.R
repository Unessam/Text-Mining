library(pacman)
library(rio)
install.packages("clipr", "csvy", "feather", "fst", "hexView", "readODS", "rmatio", "xml2")
p_load(rio)

text<- readLines("C://Users//ARAD//Desktop//Data science//Salford//handouts//data mining//ASDM//w5//TMwithR.txt")
install.packages('tm')
library(tm)

head(text)
summary(text)
str(text)
length(text)
corpus<- Corpus(VectorSource(text))
inspect(corpus[1])
textclean<- tm_map(corpus, tolower)
inspect(textclean[1])
getTransformations()
textclean<- tm_map(textclean, removeNumbers)
textclean<- tm_map(textclean, removePunctuation)
textclean<- tm_map(textclean, removeWords, stopwords(kind='en'))
textclean<- tm_map(textclean, stripWhitespace)

inspect(textclean[8])

install.packages("SnowballC")
library(SnowballC)

help("TermDocumentMatrix")


dtm <- TermDocumentMatrix(textclean,
                          control = list(minWordLength=c(1,Inf), stemming= TRUE))
)

dtm
findFreqTerms(dtm, lowfreq = 2)

termFrequency <- rowSums(as.matrix(dtm))
termFrequency
termFrequency <- subset(termFrequency, termFrequency>= 15)
termFrequency
barplot(termFrequency, las=2, col=rainbow(8))
install.packages("wordcloud")
library(wordcloud)
wordfreq <- sort(termFrequency, decreasing = TRUE)
wordfreq
wordcloud(words= names(wordfreq), freq = wordfreq, max.words = 50, min.freq = 10,
          random.order= F, colors=brewer.pal(6,"Dark2"))
barplot(wordfreq[1:50], xlab = "term", ylab = "frequency", las=2, col=heat.colors(50))
