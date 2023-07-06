capture program drop name_text
program define name_text
    version 16
    syntax, name(string) [using(string)]
    if "`using'" == "" {
        local using "cowcaploc.dta"
    }
    use "`using'", clear
    gen match = ustrupper(country) == ustrupper("`name'")
    qui sum match
    if r(sum) == 0 {
        di as err "No matching country name found"
    } 
    else {
        qui levelsof cowcode if match, local(country_code)
        di as txt `"`country_code'"'
    }
end
