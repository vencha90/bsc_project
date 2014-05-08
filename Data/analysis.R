# Adapted from
# http://stackoverflow.com/questions/12913446/efficiently-create-dataframe-from-strings-containing-key-value-pairs

setwd("c:\\Users/user/Dropbox/Documents/ABDN/Y4/PROJECT/Data/")
file <- "standard/test.log"

names <- setNames(1:8, c("time", "action", "reward", "busy_for", "location", "destination", "passenger", "fare"))

unformatted_data <- c(readLines(file))
d1 <- gsub(", ", "=", unformatted_data)
d2 <- gsub('"', "", d1)
d3 <- gsub("\\[", "", d2)
data <- gsub("\\]", ";", d3)

assign <- function(data, names){
  xx <- sapply(data, function(i) i)
  z <- rep(NA, length(names))
  z[names[xx[1, ]]] <- xx[2, ]
  z
}

sx <- lapply(strsplit(data, ";"), strsplit, "=")
ret <- t(sapply(sx, assign, names))
colnames(ret) <- names(names)
ret
