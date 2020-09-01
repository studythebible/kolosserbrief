

bookdown::render_book("index.Rmd", "bookdown::gitbook")

bookdown::render_book("index.Rmd", "bookdown::pdf_book")
bookdown::render_book("index.Rmd", "bookdown::tufte_book2")


library(rmarkdown)
library(bookdown)
library(komadown)
scrartcl("index.Rmd")

