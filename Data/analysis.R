# Adapted from
# http://stackoverflow.com/questions/12913446/efficiently-create-dataframe-from-strings-containing-key-value-pairs

setwd("c:\\Users/user/Dropbox/Documents/ABDN/Y4/PROJECT/Data/standard/")
normal_file <- "normal.log"
benchmark_file <- "benchmark.log"

names <- setNames(1:8, c("time",    "action",    "reward",  "busy_for", "location",  "destination", "passenger", "fare"))
column_types <-        c('numeric', 'character', 'numeric', 'numeric',  'character', 'character',   'character', 'numeric')
numeric_names <- c('time', 'reward', 'busy_for', 'fare')
factor_names <- c('action', 'location', 'destination', 'passenger')

format_data <- function(file) {
  unformatted_data <- c(readLines(file))
  d1 <- gsub(", ", "=", unformatted_data)
  d2 <- gsub('"', "", d1)
  d3 <- gsub("\\[", "", d2)
  data <- gsub("\\]", ";", d3)
  data
}

assign <- function(data, names){
  pairs <- sapply(data, function(i) i)
  result <- rep(c(NA), length(names))
  keys <- names[pairs[1, ]]
  values <- pairs[2, ]
  result[keys] <- values
  result
}

data_table <- function(data) {
  sx <- lapply(strsplit(data, ";"), strsplit, "=")
  ret <- t(sapply(sx, assign, names))
  colnames(ret) <- names(names)
  res <- as.data.frame(ret, na.strings=NA, stringsAsFactors=FALSE)
  res
}

fix_types <- function(data) {
  for(name in numeric_names) {
    data[, name] <- sapply(data[, name], as.numeric)
  }
  for(name in factor_names) {
    data[, name] <- sapply(data[, name], as.factor)
  }
  data
}

normal_data <- fix_types(data_table(format_data(normal_file)))
summary(normal_data)
# benchmark_data <- fix_types(data_table(format_data(benchmark_file)))
