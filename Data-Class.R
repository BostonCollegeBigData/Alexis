?WORK_WCAS_DATA_CLASS <- read.csv("~/Documents/ECON/Big Data/WORK_WCAS_DATA_CLASS.csv", stringsAsFactors= FALSE)

#install.packages("tidyr") 

library(tidyr)

WORK_WCAS_DATA_CLASS2 <- WORK_WCAS_DATA_CLASS %>%
    gather("EmailType", "Y/N",no_affinity_email:no_survey_email, na.rm = TRUE)

WORK_WCAS_DATA_CLASS3<-WORK_WCAS_DATA_CLASS2[!grep("N", WORK_WCAS_DATA_CLASS2$Y/N),]

WORK_WCAS_DATA_CLASS3


