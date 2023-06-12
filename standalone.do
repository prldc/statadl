// Working Directory

// Load dataset
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

// Need something that checks whether a particular year for a country in the user dataset is present in the COW dataset
// Maybe some code like name_text/name_code that prints a country's name/year coverage


///// 1960 /////
preserve

keep if year==1960
sort country
gen ccode = _n
keep ccode caplong caplat
save "cap loc.dta", replace

rename (ccode caplat caplong) =2
cross using "cap loc.dta"
geodist2 caplat caplong caplat2 caplong2, gen(d)

drop caplat* caplong*
format %8.0g d
reshape wide d, i(ccode) j(ccode2)

mata:
X = st_data(., "d*")
r = cols(X)
c = cols(X)
Z = 99999 * (X :== 0) + (X :> 0) :* X
W1960 = J(r,c,0)
for (i=1; i<=c; i++) {
        o = order(Z,i)
        W1960[o[1..10],i] = J(10,1,1)
}
W1960 = W1960'

st_matrix("W1960", W1960)

end

restore



///// 1965 /////
preserve

keep if year==1965
sort country
gen ccode = _n
keep ccode caplong caplat
save "caploc.dta", replace

rename (ccode caplat caplong) =2
cross using "caploc.dta"
geodist2 caplat caplong caplat2 caplong2, gen(d)

drop caplat* caplong*
format %8.0g d
reshape wide d, i(ccode) j(ccode2)

mata:
X = st_data(., "d*")
r = cols(X)
c = cols(X)
Z = 99999 * (X :== 0) + (X :> 0) :* X
W1965 = J(r,c,0)
for (i=1; i<=c; i++) {
        o = order(Z,i)
        W1965[o[1..10],i] = J(10,1,1)
}
W1965 = W1965'

st_matrix("W1965", W1965)

end

restore



///// 1970 /////
preserve

keep if year==1970
sort country
gen ccode = _n
keep ccode caplong caplat
save "caploc.dta", replace

rename (ccode caplat caplong) =2
cross using "caploc.dta"
geodist2 caplat caplong caplat2 caplong2, gen(d)

drop caplat* caplong*
format %8.0g d
reshape wide d, i(ccode) j(ccode2)

mata:
X = st_data(., "d*")
r = cols(X)
c = cols(X)
Z = 99999 * (X :== 0) + (X :> 0) :* X
W1970 = J(r,c,0)
for (i=1; i<=c; i++) {
        o = order(Z,i)
        W1970[o[1..10],i] = J(10,1,1)
}
W1970 = W1970'

st_matrix("W1970", W1970)

end

restore



///// 1975 /////
preserve

keep if year==1975
sort country
gen ccode = _n
keep ccode caplong caplat
save "caploc.dta", replace

rename (ccode caplat caplong) =2
cross using "caploc.dta"
geodist2 caplat caplong caplat2 caplong2, gen(d)

drop caplat* caplong*
format %8.0g d
reshape wide d, i(ccode) j(ccode2)

mata:
X = st_data(., "d*")
r = cols(X)
c = cols(X)
Z = 99999 * (X :== 0) + (X :> 0) :* X
W1975 = J(r,c,0)
for (i=1; i<=c; i++) {
        o = order(Z,i)
        W1975[o[1..10],i] = J(10,1,1)
}
W1975 = W1975'

st_matrix("W1975", W1975)

end

restore



///// 1980 /////
preserve

keep if year==1980
sort country
gen ccode = _n
keep ccode caplong caplat
save "caploc.dta", replace

rename (ccode caplat caplong) =2
cross using "caploc.dta"
geodist2 caplat caplong caplat2 caplong2, gen(d)

drop caplat* caplong*
format %8.0g d
reshape wide d, i(ccode) j(ccode2)

mata:
X = st_data(., "d*")
r = cols(X)
c = cols(X)
Z = 99999 * (X :== 0) + (X :> 0) :* X
W1980 = J(r,c,0)
for (i=1; i<=c; i++) {
        o = order(Z,i)
        W1980[o[1..10],i] = J(10,1,1)
}
W1980 = W1980'

st_matrix("W1980", W1980)

end

restore




///// 1985 /////
preserve

keep if year==1985
sort country
gen ccode = _n
keep ccode caplong caplat
save "caploc.dta", replace

rename (ccode caplat caplong) =2
cross using "caploc.dta"
geodist2 caplat caplong caplat2 caplong2, gen(d)

drop caplat* caplong*
format %8.0g d
reshape wide d, i(ccode) j(ccode2)

mata:
X = st_data(., "d*")
r = cols(X)
c = cols(X)
Z = 99999 * (X :== 0) + (X :> 0) :* X
W1985 = J(r,c,0)
for (i=1; i<=c; i++) {
        o = order(Z,i)
        W1985[o[1..10],i] = J(10,1,1)
}
W1985 = W1985'

st_matrix("W1985", W1985)

end

restore




///// 1990 /////
preserve

keep if year==1990
sort country
gen ccode = _n
keep ccode caplong caplat
save "caploc.dta", replace

rename (ccode caplat caplong) =2
cross using "caploc.dta"
geodist2 caplat caplong caplat2 caplong2, gen(d)

drop caplat* caplong*
format %8.0g d
reshape wide d, i(ccode) j(ccode2)

mata:
X = st_data(., "d*")
r = cols(X)
c = cols(X)
Z = 99999 * (X :== 0) + (X :> 0) :* X
W1990 = J(r,c,0)
for (i=1; i<=c; i++) {
        o = order(Z,i)
        W1990[o[1..10],i] = J(10,1,1)
}
W1990 = W1990'

st_matrix("W1990", W1990)

end

restore




///// 1995 /////
preserve

keep if year==1995
sort country
gen ccode = _n
keep ccode caplong caplat
save "caploc.dta", replace

rename (ccode caplat caplong) =2
cross using "caploc.dta"
geodist2 caplat caplong caplat2 caplong2, gen(d)

drop caplat* caplong*
format %8.0g d
reshape wide d, i(ccode) j(ccode2)

mata:
X = st_data(., "d*")
r = cols(X)
c = cols(X)
Z = 99999 * (X :== 0) + (X :> 0) :* X
W1995 = J(r,c,0)
for (i=1; i<=c; i++) {
        o = order(Z,i)
        W1995[o[1..10],i] = J(10,1,1)
}
W1995 = W1995'

st_matrix("W1995", W1995)

end

restore



///// 2000 /////
preserve

keep if year==2000
sort country
gen ccode = _n
keep ccode caplong caplat
save "caploc.dta", replace

rename (ccode caplat caplong) =2
cross using "caploc.dta"
geodist2 caplat caplong caplat2 caplong2, gen(d)

drop caplat* caplong*
format %8.0g d
reshape wide d, i(ccode) j(ccode2)

mata:
X = st_data(., "d*")
r = cols(X)
c = cols(X)
Z = 99999 * (X :== 0) + (X :> 0) :* X
W2000 = J(r,c,0)
for (i=1; i<=c; i++) {
        o = order(Z,i)
        W2000[o[1..10],i] = J(10,1,1)
}
W2000 = W2000'

st_matrix("W2000", W2000)

end

restore




// Compile W matrix
preserve

mata:

W_compile = blockdiag(W1960, blockdiag(W1965, blockdiag(W1970, blockdiag(W1975, blockdiag(W1980, blockdiag(W1985, blockdiag(W1990, blockdiag(W1995, W2000))))))))


st_matrix("W_compile", W_compile)

end


restore


// Create modified cowcodes to avoid duplicate IDs that cause errors
gen ccode=_n

sort year country
mata:
id = st_data(., "ccode")
end

// Store W matrix using spmatrix
spmatrix spfrommata W_all = W_compile id, normalize(row)

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
