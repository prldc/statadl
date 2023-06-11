capture program drop name_code
program define name_code
    version 16
    syntax, code(integer) [using(string)]
    if "`using'" == "" {
        local using "cowcaploc.dta"
    }
    use "`using'", clear
    gen match = (cowcode == `code')
    qui sum match
    if r(sum) == 0 {
        di as err "No matching cowcode found"
    } 
    else {
        qui levelsof country if match, local(country_name)
        di as txt `"`country_name'"'
    }
end
