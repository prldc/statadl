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

make_ntspmat country year 10
		
	
		
spset ccode, coord(caplat caplong)


// Table 1 Column 1
spregress polity4 lrgdpchL, ml dvarlag(W_all) vce(robust)

// Table 1 Column 2
spregress polity4 lrgdpchL i.year, ml dvarlag(W_all) vce(robust)

// Table 1 Column 3
egen id = group(country)
spregress polity4 lrgdpchL i.id i.year, ml dvarlag(W_all) vce(robust)

// Table 1 Column 5
spregress polity4 polity4L lrgdpchL i.year, ml dvarlag(W_all) vce(robust)


