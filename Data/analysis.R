# Adapted from
# http://stackoverflow.com/questions/12913446/efficiently-create-dataframe-from-strings-containing-key-value-pairs

setwd("c:\\Users/user/Dropbox/Documents/ABDN/Y4/PROJECT/Data/")
file <- "standard/test.log"

names <- c("time", 'passenger', 'fare', 'location', 'destination', 'reward', 'location', 'busy_for', 'action')

unformatted_data <- readLines(file)
d1 <- gsub(", ", "=", unformatted_data)
d2 <- gsub('"', "", d1)
d3 <- gsub("\\[", "", d2)
data <- gsub("\\]", ";", d3)

unlist.info <- function(names, column){
  info.mat <- matrix(rep('-', length(column)*length(names)), nrow=length(column), ncol=length(names), dimnames=list(c(), names))
  info.mat <- as.data.frame(info.mat, stringsAsFactors=F)

  for (i in 1:length(column)){
    row <- unlist(strsplit(column[i], ";"))
    for (item in row){
      item <- unlist(strsplit(item, "\\="))
      key_index <- which(names == item[1])
      value <- paste(item[2])
      info.mat[i,key_index] <- value
    }
  }
  return(info.mat)
}

table <- unlist.info(names, data)
