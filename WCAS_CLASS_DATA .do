************************
***  Alexis Raymond  ***
***  Big Data        ***
************************

****WCAS_CLASS DATA DONATION****
clear all
cd "/Users/alexisraymond/Documents/ECON/Big Data"
set more off
import delimited "/Users/alexisraymond/Documents/ECON/Big Data/WORK_WCAS_DATA_CLASS.csv", encoding(ISO-8859-1)


**** Dummy Variable for Donate
	gen donate = 0
	replace donate = 1 if lifetime_cash > 0
	label var donate "Donor"


**** Dummy Variable for FY15 Donations
	gen fy15donate = 0
	replace fy15donate = 1 if fy15_cash > 0
	replace fy15donate = . if missing(fy15_cash)
	label var fy15donate "FY15 Donor"

**** Dummy Variable for FY16 Donations
	gen fy16donate = 0 
	replace fy16donate = 1 if fy16_cash > 0
	replace fy16donate = . if missing(fy16_cash)
	label var fy16donate "FY16 Donor"
	
**** Save Changes as CSV
	export delimited ///
	using "/Users/alexisraymond/Documents/ECON/Big Data/WORKdata.csv", replace
	
save WCAS_CLASS_DATA, replace
clear all
use WCAS_CLASS_DATA	
	
encode ugrad_school, gen(_ugrad_school)
encode pref_chapter, gen(_pref_chapter)

set more off
eststo clear
	
label var lifetime_cash "Life-time Cash"
label var lifetime_commit "Life-time Commitment"
label var ltw_cash "Light the World Cash"
label var ltw_commit "Light the World Commitment"
label var fy15_cash "Fiscal Year 2015 Cash"
label var fy15_commit "Fiscal Year 2015 Commitment"	
label var fy16_cash "Fiscal Year 2016 Cash"
label var fy16_commit "Fiscal Year 2016 Commitment"	

sum lifetime_cash lifetime_commit ltw_cash ltw_commit fy15_cash fy15_commit fy16_cash fy16_commit, detail
ssc install estout, replace	
	
estpost tabstat lifetime_cash lifetime_commit ltw_cash ltw_commit fy15_cash fy15_commit fy16_cash fy16_commit, stats(mean sd sk kurt min p5 p25 p50 p75 p95 max) ///
                      column(statistics)
esttab using DonateSummaryStats.rtf, ///
        cells("mean(fmt(2)) sd skewness kurtosis min p5 p25 p50 p75 p95 max") ///
        replace ///
        plain ///
        label ///
        varwidth(30) ///
        nomtitles ///
        nonumbers ///
        title("Table 1. Summary statistics: Donations") ///
        addnote("Note: 72,951 Observations" ///
                "Source: Boston College Office of University Advancement")  
					
***regression***
***Using MCAS (College of Arts and Science) as the ommitted variable 
***  or reference category *** ib4._ugrad_school
	
eststo clear
eststo: tobit ltw_cash ib4._ugrad_school, ll(0)
eststo: tobit fy15_cash ib4._ugrad_school, ll(0)
eststo: tobit fy16_cash ib4._ugrad_school, ll(0)
eststo: tobit lifetime_cash ib4._ugrad_school, ll(0)	
esttab using tobitreg.rtf, ///
          replace ///
		  label ///
          depvars ///
          varwidth(30) ///
          title("Table 2. Tobit Regression of Cash Donations by Undergraduate School") ///
          nonotes ///
          addnote("Note 1:  Robust standard errors are displayed in parenthesis." ///
                  "Significance levels:  * p<0.10; ** p<0.05; *** p<0.01")

eststo clear
eststo: tobit ltw_cash ib4._ugrad_school, ll(0) ul(1000)
eststo: tobit fy15_cash ib4._ugrad_school, ll(0) ul(1000)
eststo: tobit fy16_cash ib4._ugrad_school, ll(0) ul(1000)
eststo: tobit lifetime_cash ib4._ugrad_school, ll(0) ul(1000)	
esttab using tobitreg_ugrad_ll_and_ul.rtf, ///
          replace ///
		  label ///
          depvars ///
          varwidth(30) ///
          title("Table 3. Tobit Regression of Cash Donations by Undergraduate School, >=0 and <= 1000") ///
          nonotes ///
          addnote("Note 1:  Robust standard errors are displayed in parenthesis." ///
                  "Significance levels:  * p<0.10; ** p<0.05; *** p<0.01")				  

eststo clear
eststo: logistic donate ib4._ugrad_school, coef
esttab using logisticreg_ugrad.rtf, ///
          replace ///
		  label ///
          depvars ///
          varwidth(30) ///
          title("Table 4. Logistic Regression of Donation by Graduate School") ///
          nonotes ///
          addnote("Note 1:  Robust standard errors are displayed in parenthesis." ///
                  "Significance levels:  * p<0.10; ** p<0.05; *** p<0.01")				  
				  
eststo clear
eststo: tobit ltw_cash ib29._pref_chapter, ll(0) ul(1000)
eststo: tobit fy15_cash ib29._pref_chapter, ll(0) ul(1000)
eststo: tobit fy16_cash ib29._pref_chapter, ll(0) ul(1000)
eststo: tobit lifetime_cash ib29._pref_chapter, ll(0) ul(1000)	
esttab using tobitreg_chapter.rtf, ///
          replace ///
		  label ///
          depvars ///
          varwidth(30) ///
          title("Table 5. Tobit Regression of Cash Donations by Preferred Chapter") ///
          nonotes ///
          addnote("Note 1:  Robust standard errors are displayed in parenthesis." ///
                  "Significance levels:  * p<0.10; ** p<0.05; *** p<0.01")				  

*FIN*				  				  
