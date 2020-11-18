cd "C:\Users\81804\Desktop\Data\govbudget"

clear all

import delimited "C:\Users\81804\Desktop\Data\govbudget\control_demographic.csv", ///
clear 

drop v1 workageshare

save pop.dta, replace

clear all

import excel "C:\Users\81804\Desktop\Data\govbudget\provbudget_all.xlsx", ///
sheet("budget") firstrow

reshape long budget, i(province) j(fiscalyear)
destring province, replace

gen year = fiscalyear - 1 
/* This var will be used to match population in the previous year, in which the
budget is announced. 
*/

merge m:1 province year using pop.dta
drop if _merge == 2
drop _merge
drop year

gen budgetpcap = budget/totalpop

save budgetpcap.dta, replace







