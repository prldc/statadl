mata:
void blockdiag_matrix(string scalar matrix_list) {
    // Split the list into an array of matrix names
    matrix_names = tokens(matrix_list)

    // Initialize W_compile as the last matrix in the list
    W_compile = st_matrix(matrix_names[length(matrix_names)])

    // Loop over the rest of the matrices in the list in reverse order
    for (i=length(matrix_names)-1; i>=1; i--) {
        // Add the current matrix to W_compile using blockdiag
        W_compile = blockdiag(st_matrix(matrix_names[i]), W_compile)
    }

    // Save W_compile as a Mata matrix
    st_matrix("W_compile", W_compile)
}
end
