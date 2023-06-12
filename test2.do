
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
