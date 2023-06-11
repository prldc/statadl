{smcl}
{help name_text}
{title:Name Text}
{p 2 8 1: {bf:name_text} -- Returns the cowcode corresponding to a country name.}

{cmd:name_text, name(string) [using(string)]}

{optlist 30: 
  {it: name(}{it: string)} specifies the name of the country.
  {it: using(}{it: string)} specifies the path to the cowcaploc.dta dataset. If not specified, the function will attempt to use the dataset in the directory where the package is installed.
}

{bf:Description}
{name_text} is used to find the cowcode corresponding to a specific country name. It uses the country variable in the cowcaploc.dta dataset to find the corresponding cowcode.

{bf:Options}
{p 8 2 1: {it:name(}{it:string)} is required and specifies the country name for which the cowcode is to be returned.}

{p 8 2 1: {it:using(}{it:string)} is optional and specifies the path to the cowcaploc.dta dataset. If not provided, the function will attempt to use the dataset in the directory where the package is installed.}

{bf:Dataset}
This function requires the cowcaploc.dta dataset, which is included with this package. By default, upon installation of the package using {it: net install}, the dataset will be located in the PLUS directory. You can check the location of the PLUS directory in Stata by typing {it: sysdir}. 

However, if you specified a different directory during installation, the dataset will be located in that directory.

To use the dataset with this function, specify its location using the {it: using} option, like this: 

{p 8 20: . name_text, name('Uruguay') using("`c(sysdir_plus)'cowcaploc.dta")}

If you do not specify the {it: using} option, the function will attempt to use the dataset in the current working directory. If you encounter any issues, please ensure that the directory you're specifying contains the cowcaploc.dta file.

{bf:Saved Results}
{name_text} saves the following in {it:r()}: 

{p 8 20: Scalars} 
  {p 8 20: r(country_code) cowcode for the specified country}

{bf: Authors}
Pedro Luz de Castro, University of Michigan, [pldc@umich.edu](mailto:pldc@umich.edu){.email}
Jude Hays, University of Pittsburgh, [jch61@pitt.edu](mailto:jch61@pitt.edu){.email}
Valentina González-Rostani, University of Pittsburgh, [mag384@pitt.edu](mailto:mag384@pitt.edu){.email}
Scott Cook, Texas A&M University, [sjcook@tamu.edu](mailto:sjcook@tamu.edu){.email}
Robert Franzese, University of Michigan, [franzese@umich.edu](mailto:franzese@umich.edu){.email}
Wooseok Kim, University of Michigan, [wskr@umich.edu](mailto:wskr@umich.edu){.email}
