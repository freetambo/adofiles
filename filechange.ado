
/*
version 0.2
k.leuveld@surveybe.com
This ado file finds changes in json files.

Version: 02.1 
Changelog:
12/1/2018: 	v0.1	Koen 	Yay! It works
30/1/2018	v0.2	Koen	Added help
							Added type option
							fixed error when no files where no files were present
09/01/2019	V0.2.1	Koen	Added version message

*/
*! Filechange v0.2.1 9jan2019 k.leuveld@surveybe.com
program filechange
	syntax , in(string) out(string) type(string) [fulldetails]

	*we use a specific windows command, so check if that works
	assert c(os) == "Windows"
	qui{
		*do a dir of all files in folder and save it to file
		tempfile dirlist
		di "`dirlist'"
		!dir /-C  "`in'" > `dirlist'
		import delimited using `dirlist', delimiter(space, collapse) varnames(nonames) clear

		*clean up
		keep if regexm(v4,".`type'$")
		ren v1 date
		ren v2 time
		ren v3 size
		ren v4 filename
		keep date time size filename
		gen double timestamp = .
		if _N > 0{
			replace timestamp = clock(time+" "+date, "hm DMY")
		}
		format timestamp %tc
		drop date time

		*save the current file list
		local timestamp: di %tcCCYYNNDDHHMMSS clock(c(current_date)+c(current_time),"DMYhms")
		if length("`fulldetails'")!=0{
			save "`out'\files_`timestamp'.dta", replace
		}
		tempfile thisrun
		save `thisrun'

		*then get last run, and merge it
		cap confirm file "`out'\files_lastrun.dta"
		if _rc == 0{
			ren timestamp new_timestamp
			ren size new_size
			merge 1:1 filename using  "`out'\files_lastrun.dta"
			
			*clean up and save the file
			gen change = timestamp != new_timestamp
			gen comment = "File has been changed" if change
			replace comment = "New interview file" if _merge == 1
			replace comment = "Interview file deleted" if _merge == 2
			drop if comment == ""
			ren timestamp old_timestamp
			ren size old_size
			drop _merge change
			sort new_timestamp
			order filename old_timestamp new_timestamp old_size new_size comment
			if length("`fulldetails'")!=0{
				save "`out'\changes_`timestamp'.dta", replace		
			}
			gen logdate = clock(c(current_date)+c(current_time),"DMYhms")
			format logdate %tc
			cap confirm file "`out'\changes_all.dta"
			if _rc == 0{
				append using "`out'\changes_all.dta"
			}
			save "`out'\changes_all.dta", replace
		}
		else{
			di "lastrun.dta not found"
		}
		preserve
		use `thisrun', clear
		save "`out'\files_lastrun.dta", replace
		restore
	}
end
