{title:Merge COW Data}

{p 8 0: merge_cowdata}
{synopsis: merge_cowdata, country(string) year(string)}
{cmd: merge_cowdata, country("country_name") year("year")}
{remarks:
{p 8 0: merge_cowdata} is a program specifically designed to merge your dataset with the Correlates of War (COW) 'cowcaploc.dta' dataset based on a specified country and year. This program also lists out non-matched entries based on country and year after the merge operation, facilitating the troubleshooting of any discrepancies.}

{p 8 0:Options}
{p 8 2:country(string): Specify the name of the country variable in your dataset.}
{p 8 2:year(string): Specify the name of the year variable in your dataset.}

{p 8 0:Example}
{cmd:merge_cowdata, country("country") year("year")}

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

{p 8 0: Also see}
{help merge} {help save}
