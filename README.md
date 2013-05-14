##Features:

Print any month 1-12 of any year 1-9999 when given following month/year input types:

 * ruby cal.rb April &lt;year>
 * ruby cal.rb april &lt;year>
 * ruby cal.rb Apr\* &lt;year>
 * ruby cal.rb apr\* &lt;year>
 * ruby cal.rb 4 &lt;year>
 * ruby cal.rb 04 &lt;year>
 * ruby cal.rb 004 &lt;year>

Print any year from 1-9999 when given input types:

 * ruby cal.rb 2013
 * ruby cal.rb 1
 * ruby cal.rb 01
 * ruby cal.rb 001
 * ruby cal.rb 0001

To run this program with a singe command, add the following to your ~/.bashrc or ~/.zshrc file:

alias rcal='ruby ~/your/file/path/cal.rb'
