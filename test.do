import excel "wooseok/aer_original.xlsx", sheet("Sheet1") firstrow clear

// Run regression to get sample
reg polity4 polity4L lrgdpchL i.year

// Keep sample
keep if e(sample)

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

capture program drop compute_w_matrix

program define compute_w_matrix, rclass
    args year caplat_var caplong_var outfile

    // Check if the year exists in the data
    qui count if year == `year'
    if r(N) == 0 {
        di as error "No data for year `year'"
        exit 198
    }

    preserve
    qui {
        keep if year == `year'
        sort country
        gen ccode = _n
        keep ccode `caplat_var' `caplong_var'
        save "cap loc.dta", replace

        rename (ccode `caplat_var' `caplong_var') =2
        cross using "cap loc.dta"
        geodist2 `caplat_var' `caplong_var' `caplat_var'2 `caplong_var'2, gen(d)

        drop `caplat_var'* `caplong_var'*
        format %8.0g d
        reshape wide d, i(ccode) j(ccode2)
    }

    mata:
    X = st_data(., "d*")
    r = cols(X)
    c = cols(X)
    Z = 99999 * (X :== 0) + (X :> 0) :* X
    W_year = J(r,c,0)
    for (i=1; i<=c; i++) {
            o = order(Z,i)
            W_year[o[1..10],i] = J(10,1,1)
    }
    W_year = W_year'
    st_matrix("`outfile'", W_year)
    end

    restore
end

// Get a list of unique years in the dataset
levelsof year, local(years)

// Compute W matrix for each unique year
foreach year of local years {
    compute_w_matrix `year' caplat caplong W`year'
}

mata:
W_compile = st_matrix("W" + st_local("years")[1])
for (i=2; i<=length(st_local("years")); i++) {
    W_compile = blockdiag(W_compile, st_matrix("W" + st_local("years")[i]))
}
end

// Create modified cowcodes to avoid duplicate IDs that cause errors
gen ccode=_n

sort year country
mata:
id = st_data(., "ccode")
end

// Store W matrix using spmatrix
spmatrix spfrommata W_all = W_compile id, normalize(row)

spset ccode, coord(caplat caplong)

