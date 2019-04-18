# install some packages
withCallingHandlers(install.packages(
    c(
    	'Cairo', 
    	'DBI', 
    	'devtools', 
    	'dplyr', 
    	'purrr',
    	'RcppArmadillo',
    	'rJava', 
    	'RJDBC', 
    	'rversions', 
    	'tidyverse'
    ),
    lib = "/usr/local/lib/R/site-library/",
    dependencies = c("Depends", "Imports", "LinkingTo"),
    INSTALL_opts = c("--no-html"),
    Ncpus = 2
), warning = function(w) stop(w))
