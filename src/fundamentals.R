#
#  UVA McIntire Seminar, Presentedby CapTech
#      R Fundamentals
#      Materials modifed from Learning Base R by Larry Leemis @2015
#    
#    objects are known in other languages as "variables" 
#    object names are case sensitive and should be chosen meaningfully
#    assignment made by = or <-  (no space)
#    typing object name displays its contents
#    ls() or objects() displays all object names 
#
x = 42                  # assignment operator
x = 4; y = 2            # the semi-colon separates the two commands 
x + y                   # sum
x * y                   # product
ls()                    # display object names 
captech.is.cool = TRUE  # meaningful object name using periods 
rm(x)                   # remove (unassign) x
rm(list = ls())         # remove all objects in current session
q()                     # quit R
