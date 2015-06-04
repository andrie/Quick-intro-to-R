# Extract R code from presentation

pres <- "Quick-intro-to-R"
infile <- paste0(pres, ".Rpres")
outfile <- paste0("standalone/", pres, ".R")
knitr::purl(infile, outfile)

file.copy("data", "standalone", recursive = TRUE)

outfile <- paste0("standalone/", pres, ".html")
# rmarkdown::render(infile, output_file = outfile)
