##Specifications

Ruby_cal is a 100% ruby implementation of the ubiquitous cal command in command line. Specifications were:

* print single month or full year calendars
* output should be functionally and aesthetically identical to cal
* should work for any month or year from 1800-3000
* development process should be test driven

##Features:

Print any month 1-12 of any year 1-9999 when given following month/year input types:

 * ruby cal.rb April &lt;year>
 * ruby cal.rb april &lt;year>
 * ruby cal.rb Apr\* &lt;year>
 * ruby cal.rb apr\* &lt;year>
 * ruby cal.rb 4 &lt;year>
 * ruby cal.rb 04 &lt;year>
 * ruby cal.rb 004 &lt;year>

Print any year from 1-9999 when given following input types:

 * ruby cal.rb 2013
 * ruby cal.rb 1
 * ruby cal.rb 01
 * ruby cal.rb 001
 * ruby cal.rb 0001

To run this program with a single command, add the following to your ~/.bashrc or ~/.zshrc file:

alias rcal='ruby ~/your/file/path/cal.rb'

Ruby_cal can now be executed by typing rcal <year> or rcal <month> <year> in command line, regardless of pwd.
