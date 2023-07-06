capture program drop make_ntspmat

program define make_ntspmat
    args country_var year_var k

    // Get a list of unique years in the dataset
    levelsof `year_var', local(years)
    
    // Initialize a local macro to store the names of the matrices
    local matrix_list ""

    foreach y of local years {
        preserve
        qui {
            keep if `year_var' == `y'
            sort `country_var'
            gen ccode = _n
            keep ccode caplat caplong
            save "`y'.dta", replace
            rename (ccode caplat caplong) =2
            cross using "`y'.dta"
            geodist2 caplat caplong caplat2 caplong2, gen(d)
            drop caplat* caplong*
            format %8.0g d
            reshape wide d, i(ccode) j(ccode2)
            mata: calculate_matrix("`y'", `k')
            local matrix_list "`matrix_list' W`y'"
        }
        restore
    }

    mata: blockdiag_matrix("`matrix_list'")
    // Converts it to a Mata matrix
    mata:  W_compile = st_matrix("W_compile")  
    gen ccode=_n
    sort `year_var' `country_var'
    mata: id = st_data(., "ccode")
    spmatrix spfrommata W_all = W_compile id, normalize(row)  
end

