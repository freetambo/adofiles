{smcl}
{* *! version 1.2.1  23aug2017}{...}
{findalias asfradohelp}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[R] help" "help help"}{...}
{viewerjumpto "Syntax" filechange##syntax"}{...}
{viewerjumpto "Description" filechange##description"}{...}
{viewerjumpto "Options" filechange##options"}{...}
{viewerjumpto "Remarks" filechange##remarks"}{...}
{viewerjumpto "Examples" filechange##examples"}{...}
{title:filechange}

{phang}
{bf:filechange} {hline 2} records the files in a folder, 
and on each subsequent run tracks the changes to files in the folder. 
Filechange creates two files in the output folder: changes_all.dta contains
all changes to the folder for each time filechange has been run. files_lastrun
contains the files in the folder the last time filechange was run.


{marker syntax}{...}
{title:Syntax}

{p 8 17 2}
{cmd:filechange,} in(folder) out(folder) type(filetype) [fulldetails]

{synoptset 30 tabbed}{...}
{synopthdr}
{synoptline}
{syntab:Main}
{synopt :{opt in(folder)}}folder to watch;{p_end}
{synopt :{opt out(folder)}}folder where the output will be put;{p_end}
{synopt :{opt fulldetail}}When specified, filechange will output will export a log of all files 
and changes to the out folder each time it is run. If not specified, only changes_all and 
files_lastrun will be created;{p_end}
{synoptline}
{p2colreset}{...}


{title:Author} 

{p 4 4 2}Koen Leuveld, EDI Ltd.{break} 
         k.leuveld@surveybe.com
