mata:
void calculate_matrix(string scalar year, real scalar k) {
    X = st_data(., "d*")
    r = cols(X)
    c = cols(X)
    Z = 99999 * (X :== 0) + (X :> 0) :* X
    W = J(r,c,0)
    for (i=1; i<=c; i++) {
        o = order(Z,i)
        W[o[1..k],i] = J(k,1,1)
    }
    W = W'
	st_matrix("W" + year, W)
}
end
