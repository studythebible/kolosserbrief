
pattern <- "\\b[a-zA-Z]+(?:\\s+\\d+)?(?::\\d+(?:–\\d+)?(?:,\\s*\\d+(?:–\\d+)?)*)?"
pattern <- "?:(?:[123]|I{1,3})\\s*)?(?:[A-Z][a-zA-Z]+|Hebräer|Hebr.|Hebr|Heb).?\\s*(?:1?[0-9]?[0-9]):\\s*\\d{1,3}(?:[,-]\\s*\\d{1,3})*(?:;\\s*(?:(?:[123]|I{1,3})\\s*)?(?:[A-Z][a-zA-Z]+|Song of Songs|Song of Solomon)?.?\\s*(?:1?[0-9]?[0-9]):\\s*\\d{1,3}(?:[,-]\\s*\\d{1,3})*)*"

y <- readLines("01_woche_01.Rmd")

x  <- y[5]

x <- paste("Test, Hebräer alone, lkj sdf Hebr. 106,8-9 und ich denke dass",
           "Hebräer 8 und Hebräer 19,1-10,12, and Heb 5.1 weil wir meine",
           "dass Hebr 4:1-4 lkj Hebr 4:1- 4.10")



pattern <- "Hebräer|Hebr.|Hebr|Heb"
m <- gregexpr(pattern, x, useBytes = FALSE)
regmatches(x, m)

pattern <- "(Hebräer|Hebr.|Hebr|Heb)\\s?(\\d{1,3})?"
m <- gregexpr(pattern, x, useBytes = FALSE)
regmatches(x, m)


pattern <- "(Hebräer|Hebr.|Hebr|Heb)\\s?(\\d{1,3})((\\.|,|:)\\d{1,2})?"
m <- gregexpr(pattern, x, useBytes = FALSE)
regmatches(x, m)

\w+\s?(\d{1,2})?(:\d{1,2})?([-–]\d{1,2})?(,\s\d{1,2}[-–]\d{1,2})?

pattern <- "(Hebräer|Hebr.|Hebr|Heb)\\s?(\\d{1,3})((\\.|,|:)\\d{1,2})?([-–]\\d{1,2})?"
m <- gregexpr(pattern, x, useBytes = FALSE)
regmatches(x, m)
# "Hebr. 106,8-9"   "Hebräer 8"       "Hebräer 19,1-10" "Heb 5.1"         "Hebr 4:1-4"

pattern <- "(Hebräer|Hebr.|Hebr|Heb)\\s?(\\d{1,3})((\\.|,|:)\\d{1,2})?([-–]\\s*\\d{1,2})?((\\.|,|:)\\d{1,2})?"
m <- gregexpr(pattern, x, useBytes = FALSE)
regmatches(x, m)

pattern <- "(He(?:bräer|br\\.|br|b))\\s?(\\d{1,3})((\\.|,|:)\\d{1,2})?([-–]\\s*\\d{1,2})?((\\.|,|:)\\d{1,2})?"
m <- gregexpr(pattern, x, useBytes = FALSE)
regmatches(x, m)


#------------ with capture expression

pattern <- "\\$(?<book>He[?:bräer|br|b])"
m <- gregexpr(pattern, x, useBytes = FALSE)
regmatches(x, m)

pattern <- "(?<book>Hebräer)"
matches <- regexpr(pattern, x, perl = TRUE)
first <- attr(matches, "capture.start")
last <- first + attr(matches, "capture.length")
substring(x, first, last)

pattern <- "(?<book>Hebräer)"
matches <- gregexpr(pattern, x, perl = TRUE)[[1]]
first <- attr(matches, "capture.start")
last <- first + attr(matches, "capture.length") -1
substring(x, first, last)

pattern <- "(?<book>(Heb(?:räer|r\\.|r|)))"
matches <- gregexpr(pattern, x, perl = TRUE)[[1]]
first <- attr(matches, "capture.start")[,1]
last <- first + attr(matches, "capture.length")[,1] -1
substring(x, first, last)


pattern <- "(?<book>Heb(?:räer|r\\.|r|))\\s?(?<chapter>\\d{1,3})"
matches <- gregexpr(pattern, x, perl = TRUE)[[1]]
first <- attr(matches, "capture.start")[,"book"]
last <- first + attr(matches, "capture.length")[,1] -1
substring(x, first, last)

pattern <- "(?<book>Heb(?:räer|r\\.|r|))\\s?(?<chapter>\\d{1,3})(?<verse>(\\.|,|:)\\d{1,2})?([-–]\\s*\\d{1,2})?((\\.|,|:)\\d{1,2})?"
matches <- gregexpr(pattern, x, perl = TRUE)[[1]]
first <- attr(matches, "capture.start")[,"book"]
last <- first + attr(matches, "capture.length")[,1] -1
substring(x, first, last)

pattern <- "(?<book>Heb(?:räer|r\\.|r|))\\s?(?<chapter>\\d{1,3})(?<verse>(\\.|,|:)\\d{1,2})?(?<verse2>[-–]\\s*\\d{1,2})?(?<verse3>(\\.|,|:)\\d{1,2})?"

pattern <- "(?<book>Heb(?:räer|r\\.|r|))\\s?(?<chapter>\\d{1,3})(\\.|,|:)?(?<verse>\\d{1,2})?([-–]\\s*)?(?<verse2>\\d{1,2})?(\\.|,|:)?(?<verse3>\\d{1,2})?"
matches <- gregexpr(pattern, x, perl = TRUE)[[1]]
mnames <- attr(matches, "capture.names")
mnames <- mnames[mnames != ""]
first <- attr(matches, "capture.start")[, mnames]
last <- first + attr(matches, "capture.length")[, mnames]-1

u <- mapply(substring, x, first, last, USE.NAMES = FALSE)
dim(u) <- c(nrow(first), ncol(first))

u

paste("Test, Hebräer alone, lkj sdf Hebr. 106,8-9 und ich denke dass",
      "Hebräer 8 und Hebräer 19,1-10,12, and Heb 5.1 weil wir meine",
      "dass Hebr 4:1-4 lkj Hebr 4:1- 4.10")


# FUN <- function(first, last, x){
#   v <- substring(x, first, last)
#   if(length(v) == 0){
#     return(NA)
#   }else{
#     v
#   }
# }
#
# #
# u <- mapply(FUN, first, last, MoreArgs = list(x)) # identical to below
# u <- mapply(substring, x, first, last, USE.NAMES = FALSE)
# dim(u) <- c(nrow(first), ncol(first))
#
# u

x <- paste("Test, Hebräer alone, lkj sdf Hebr. 106,8-9 und ich denke dass",
           "Hebräer 8 und Hebräer 19,1-10,12, and Heb 5.1 weil wir meine",
           "dass Hebr 4:1-4 lkj Hebr 4:1- 4.10")


#------------------------------------------------------------------------------#
library(XML)

if(length(xmltxt) == 0){
  return(NULL)
}


xmltxt <- "/mnt/data/huber/Documents/BIBLIOTHEQUE/biblique/bibles/osis-bibles-master/de/sch1951.xml"
doc <- XML::xmlParse(xmltxt)

nbChapter <- function(doc, x){
  path <- paste0("/osis//div[@osisID='", x, "']")
  chp_nodeset <- getNodeSet(doc, path)
  chp_vrs <- xmlChildren(chp_nodeset[[1]])
  length(chp_vrs)
}

# x = abbreviation: e.g. Gen
nbVerse <- function(doc, x, chp = 1){
  path <- paste0("/osis//chapter[@osisID='", x, ".", chp,"']")
  chp_nodeset <- getNodeSet(doc, path)
  chp_vrs <- xmlChildren(chp_nodeset[[1]])
  length(chp_vrs)
}

getVerse <- function(doc, book, chap, v, v1 = NULL, v2 = NULL){
  n <- nbVerse(doc, book, chp = chap)
  if(is.null(v1)){
    if(v > n) stop("v > n")
    path <- paste0("/osis//verse[@osisID='", book ,".", chap ,".", v ,"']")
    elt <- getNodeSet(doc, path)
    XML::xmlValue(elt)
  }else if(!is.null(v1) && is.null(v2)){
    if(v1 > n) stop("v1 > n")
    u <- v:v1
    txt <- getnVerse(doc, book, chap, u)
    # txt <- numeric(length(u))
    # for(i in seq_along(u)){
    #   path <- paste0("/osis//verse[@osisID='", book ,".", chap ,".", u[i] ,"']")
    #   elt <- getNodeSet(doc, path)
    #   txt[i] <- XML::xmlValue(elt)
    # }
    return(txt)
  }else if(!is.null(v1) && !is.null(v2)){
    if(chap > v1) stop("chap > v1")
    nn <- nbVerse(doc, book, v1)
    if(v2 > nn) stop("v2 > nn")
    uchap <- chap:v1
    txt <- list()
    for(i in seq_along(uchap)){
      if(i == 1){
        vi <- v:n
      }else if(i == length(uchap)){
        vi <- 1:v2
      }else{
        vi <- seq_len(nbVerse(doc, book, uchap[i]))
      }
      txt[[i]] <- getnVerse(doc, book,  uchap[i], vi)
    }
    unlist(txt)
  }
}

getnVerse <- function(doc, book, chap, v){
  txt <- numeric(length(v))
  for(i in seq_along(v)){
    path <- paste0("/osis//verse[@osisID='", book ,".", chap ,".", v[i] ,"']")
    elt <- getNodeSet(doc, path)
    txt[i] <- XML::xmlValue(elt)
  }
  return(txt)
}

nbChapter(doc, "Num")
nbVerse(doc, "Gen", chp = 3)

getVerse(doc, "Gen", 3, 12)
getVerse(doc, "Gen", 3, 12, 15)
getVerse(doc, "Gen", 3, 12, 4, 15)

# WRONG
getVerse(doc, "Gen", 3, 72)
getVerse(doc, "Gen", 3, 12, 54)
getVerse(doc, "Gen", 3, 12, 1, 3)




elt <- getNodeSet(doc, "/osis//verse[@osisID='Gen.1.5']")
XML::xmlValue(elt)

chp <- getNodeSet(doc, "/osis//chapter[@osisID='Gen.1']")
length(chp[[1]])
chp$children
sapply(chp, xmlGetAttr, "osisID")

chp_vrs <- xmlChildren(chp[[1]])
length(chp_vrs)

sapply(xmlChildren(chp[[1]]), xmlGetAttr, "osisID")


doc = xmlParse(system.file("exampleData", "tagnames.xml", package = "XML"))
getNodeSet(doc, "/doc")
getNodeSet(doc, "/doc//a")
getNodeSet(doc, "/doc//a[@status]")
getNodeSet(doc, "/doc//a[@status='foo']")
