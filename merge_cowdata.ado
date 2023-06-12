capture program drop merge_cowdata

program define merge_cowdata
    version 16
    syntax, country(string) year(string) [using(string)]
    if "`using'" == "" {
        local using "cowcaploc.dta"
    }
    tempfile mymerge
    save "`mymerge'"
    use "`using'", clear
    tempfile usingmerge
    save "`usingmerge'"
    use "`mymerge'", clear
    merge m:1 `country' `year' using "`usingmerge'"
    di "Non-matched entries:"
    list `country' `year' if _merge == 1
    drop if _merge == 1
    drop _merge
    di as txt "Merge completed. Non-matched entries listed. Please manually correct the entries."
end
