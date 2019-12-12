    cranlist <- c(
                  "data.table",
                  "DBI",
                  "dbplyr",
                  "devtools",
                  "gdtools",
                  "htmltidy",
                  "httr",
                  "IRkernel",
                  "jsonlite",
                  "listviewer",
                  "mongolite",
                  "odbc",
                  "RPostgreSQL",
                  "sqldf",
                  "tidyverse",
                  "XML",
                  "xml2",
                  "plotly"
    )

    # later tidyverse and plotly

    #mirid <- match("tr", getCRANmirrors()[,8])
    #chooseCRANmirror(graphics=FALSE, ind=mirid)

    ## cran packages
    for (package in cranlist)
    { 
        if (!require(package, character.only = T, quietly = T))
        {
            install.packages(package)
        }
    }

    # initiate IRkernel
    IRkernel::installspec(user = FALSE)

