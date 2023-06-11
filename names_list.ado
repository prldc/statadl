capture program drop names_list

program define names_list
    syntax using/
    use `using', clear
    levelsof country, local(levels)
    di as txt `"`levels'"'
end
