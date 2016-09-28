
clear
set more off 

*change directory*
cd "/Users/alexisraymond/Documents/ECON/Big Data"

*create log file
log using WORK-Data_Manipulation.log, replace


/* Here I am changing the WORK_WCAS_DATA_CLASS file
to be more suite for a filled map in Tableau */

use "/Users/alexisraymond/Documents/ECON/Big Data/WORK_WCAS_DATA_CLASS.dta"

summarize fy15_cash, detail
/* Summarizing the fiscal year 2015 cash gifts I find
of the 197,710 observations the mean gift is 396.52. However,
I find that 75% of people who recieved emails gave $0.
I also find that the 95th percentile is 250 and the 99th percentile
is 3,000 (i.e. 99% of people email gave less than $3,000). */  

drop if fy15_cash ==0
*(164,540 observations deleted)


drop if is_deceased == "Y"
*(265 observations deleted)*

summarize fy15_cash, detail
/* New summary statistics shows 32,905 observations with a mean of 2,196,109
and a 95th percentile of 5,000 and a 99th percentile of 25,000 */

export delimited "/Users/alexisraymond/Documents/Econ/Big Data/WorkData-Dropfy15=0.csv", replace

**Clear and reload original dataset**
clear

use "/Users/alexisraymond/Documents/ECON/Big Data/WORK_WCAS_DATA_CLASS.dta"

summarize fy16_cash, detail
/* Summarizing the fiscal year 2016 cash gifts I find that of the
197,710 observations the mean gift is 376.91. 95th percentils is 250 and
the 99th percentile is 3,000.

Fiscal year 2016 had a slightly lower mean gift amount */

drop if fy16_cash == 0
*(163,080 observations deleted)

drop if is_deceased == "Y"
*(105 observations deleted)*

summarize fy16_cash, detail
/* New tabulation shows that the new mean is 2,082.87, the 95th
percentile is 4,000 and the 99th percentile is 25,000 */

export delimited "/Users/alexisraymond/Documents/Econ/Big Data/WorkData-Dropfy16=0.csv", replace

log close

clear all

