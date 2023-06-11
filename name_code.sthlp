{title: name_code}
{p 8 20: name_code, code(integer) [using(string)]}
{hline}

{name_code} displays the country name that corresponds to a specified cowcode.

{hline}

{dialog:name_code}
{tab}{inp:  code(integer)}{fill}
{tab}{inp:  [using(string)]}{fill}
{hline}

{bf:Options}
{p 8 20:code(integer)} is required. This specifies the cowcode for which you want to find the country name.
{p 8 20:using(string)} is optional. This specifies the dataset that will be used. If not provided, the default dataset will be used.
{hline}

{bf:Examples}
{p 8 20: . name_code, code(2)}
{p 8 20: . name_code, code(800) using("new_path/cowcaploc.dta")}
{hline}

{bf:Dataset}
This function requires the cowcaploc.dta dataset, which is included with this package. By default, upon installation of the package using {it: net install}, the dataset will be located in the PLUS directory. You can check the location of the PLUS directory in Stata by typing {it: sysdir}. 

However, if you specified a different directory during installation, the dataset will be located in that directory.

To use the dataset with this function, specify its location using the {it: using} option, like this: 

{p 8 20: . name_code, code(2) using("`c(sysdir_plus)'cowcaploc.dta")}

If you do not specify the {it: using} option, the function will attempt to use the dataset in the current working directory. If you encounter any issues, please ensure that the directory you're specifying contains the cowcaploc.dta file.

{bf:Authors}
{p 8 20: Pedro Luz de Castro}
{p 8 20: pldc@umich.edu}
{p 8 20: Jude Hays}
{p 8 20: jch61@pitt.edu}
{p 8 20: Valentina González-Rostani}
{p 8 20: mag384@pitt.edu}
{p 8 20: Scott Cook}
{p 8 20: sjcook@tamu.edu}
{p 8 20: Robert Franzese}
{p 8 20: franzese@umich.edu}
{p 8 20: Wooseok Kim}
{p 8 20: wskr@umich.edu}
