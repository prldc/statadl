import excel "aer_original.xlsx", sheet("Sheet1") firstrow clear

// Merge with COW
merge m:1 country year using "cowcaploc.dta", nogenerate
drop if polity4==.

// Get list of non-matched observations
tab country if cowcode==.

// Fix names (Manually)
replace country="Belarus (Byelorussia)" if country=="Belarus"
replace country="Burkina Faso (Upper Volta)" if country=="Burkina Faso"
replace country="Cambodia (Kampuchea)" if country=="Cambodia"
replace country="Congo, Democratic Republic of (Zaire)" if country=="Congo, Dem. Rep."
replace country="Congo" if country=="Congo, Rep."
replace country="Cote D'Ivoire" if country=="Cote d'Ivoire"
replace country="Egypt" if country=="Egypt, Arab Rep."
replace country="Ethiopia" if country=="Ethiopia -pre 1993"
replace country="Ethiopia" if country=="Ethiopia 1993-"
replace country="Gambia" if country=="Gambia, The"
replace country="German Federal Republic" if country=="Germany" 
replace country="Iran (Persia)" if country=="Iran"
replace country="Italy/Sardinia" if country=="Italy"
replace country="Korea, Republic of" if country=="Korea, Rep."
replace country="Macedonia (FYROM/North Macedonia)" if country=="Macedonia, FYR"
replace country="Madagascar (Malagasy)" if country=="Madagascar"
replace country="Pakistan" if country=="Pakistan-post-1972"
replace country="Pakistan" if country=="Pakistan-pre-1972"
replace country="Rumania" if country=="Romania"
replace country="Russia (Soviet Union)" if country=="Russia"
replace country="Sri Lanka (Ceylon)" if country=="Sri Lanka"
replace country="Syria" if country=="Syrian Arab Republic"
replace country="Tanzania (Tanganyika)" if country=="Tanzania"
replace country="Turkey (Ottoman Empire)" if country=="Turkey"
replace country="United States of America" if country=="United States"
replace country="Venezuela" if country=="Venezuela, RB"
replace country="Vietnam, Democratic Republic of" if country=="Vietnam"
replace country="Yemen (Arab Republic of Yemen)" if country=="Yemen"
replace country="Zimbabwe (Rhodesia)" if country=="Zimbabwe"

// Re-merge
merge m:1 country year using "cowcaploc.dta", nogenerate update
drop if polity4==.

// capture program drop make_ntspmat
//
// program define make_ntspmat
//     args year_var k
//
//     // Get a list of unique years in the dataset
//     levelsof `year_var', local(years)
//    
//     // Initialize a local macro to store the names of the matrices
//     local matrix_list ""
//
//     foreach y of local years {
//         preserve
//         qui {
//             keep if `year_var' == `y'
//             sort country
//             gen ccode = _n
//             keep ccode caplat caplong
//             save "`y'.dta", replace
//             rename (ccode caplat caplong) =2
//             cross using "`y'.dta"
//             geodist2 caplat caplong caplat2 caplong2, gen(d)
//             drop caplat* caplong*
//             format %8.0g d
//             reshape wide d, i(ccode) j(ccode2)
//             mata: calculate_matrix("`y'", `k')
//             local matrix_list "`matrix_list' W`y'"
//         }
//         restore
//     }
//
//     mata: blockdiag_matrix("`matrix_list'")
//     // Converts it to a Mata matrix
//     mata:  W_compile = st_matrix("W_compile")	
// 	gen ccode=_n
// 	sort year country
// 	mata: id = st_data(., "ccode")
// 	spmatrix spfrommata W_all = W_compile id, normalize(row)	
// end

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


make_ntspmat country year 10

// make_ntspmat year 40
		
	
		
spset ccode, coord(caplat caplong)





// Table 1 Column 1
spregress polity4 lrgdpchL, ml dvarlag(W_all) vce(robust)

// Table 1 Column 2
spregress polity4 lrgdpchL i.year, ml dvarlag(W_all) vce(robust)

// Table 1 Column 3
egen id = group(country)
spregress polity4 lrgdpchL i.id i.year, ml dvarlag(W_all) vce(robust)

// Table 1 Column 4
spregress polity4 polity4L lrgdpchL i.year, ml dvarlag(W_all) vce(robust)


